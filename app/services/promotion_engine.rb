# app/services/promotion_engine.rb
# frozen_string_literal: true

class PromotionEngine
  def initialize(cart)
    @cart = cart
    @now = Time.current
  end

  def apply_best_promotions
    @cart.cart_items.each { |ci| ci.update!(promotion_application: nil) }
    PromotionApplication.where(cart_item_id: @cart.cart_items.select(:id)).delete_all

    promotions = Promotion.active(@now).to_a

    @cart.cart_items.each do |cart_item|
      next unless (best = best_promotion_for(cart_item, promotions))
      apply_promotion(best, cart_item)
    end
  end

  private

  def best_promotion_for(cart_item, promotions)
    item = cart_item.item
    candidates = promotions.select { |p| applies_to?(p, item) && eligible?(p, cart_item) }
    return nil if candidates.empty?

    candidates.max_by { |p| savings(p, cart_item) }
  end

  def applies_to?(promotion, item)
    promotion.item_id == item.id || promotion.category_id == item.category_id
  end

  def eligible?(promotion, cart_item)
    case promotion.discount_type.to_sym
    when :buy_x_get_y
      cart_item.quantity.to_i >= (promotion.buy_quantity.to_i + promotion.get_quantity.to_i)
    when :weight_threshold
      cart_item.total_weight_grams >= promotion.threshold_grams.to_i
    else
      true
    end
  end

  def savings(promotion, cart_item)
    original = cart_item.item.price_cents * cart_item.quantity.to_i
    original - discounted_price(promotion, cart_item)
  end

  def discounted_price(promotion, cart_item)
    base = cart_item.item.price_cents * cart_item.quantity.to_i

    case promotion.discount_type.to_sym
    when :flat
      [base - (promotion.discount_value.to_d * 100).to_i, 0].max
    when :percentage
      (base * (1 - promotion.discount_value.to_d / 100)).to_i
    when :buy_x_get_y
      full_price_count = cart_item.quantity.to_i / (promotion.buy_quantity + promotion.get_quantity)
      paid = full_price_count * promotion.buy_quantity + (cart_item.quantity.to_i % (promotion.buy_quantity + promotion.get_quantity))
      paid * cart_item.item.price_cents
    when :weight_threshold
      return base if cart_item.total_weight_grams < promotion.threshold_grams.to_i
      (base * (1 - promotion.discount_value.to_d / 100)).to_i
    else
      base
    end
  end

  def apply_promotion(promotion, cart_item)
    discounted = discounted_price(promotion, cart_item)
    original = cart_item.item.price_cents * cart_item.quantity.to_i

    app = PromotionApplication.create!(
      promotion: promotion,
      cart_item: cart_item,
      applied_quantity: cart_item.quantity,
      original_price_cents: original,
      discounted_price_cents: discounted
    )
  end
end
