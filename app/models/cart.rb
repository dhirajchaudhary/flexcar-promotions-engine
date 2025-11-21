class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def add_item(item, quantity: 1, weight_grams: nil)
    cart_item = cart_items.find_or_initialize_by(item: item)

    if item.weight?
      cart_item.weight_grams = (cart_item.weight_grams || 0) + weight_grams.to_i
    else
      cart_item.quantity = (cart_item.quantity || 0) + quantity
    end

    cart_item.save!
    PromotionEngine.new(self).apply_best_promotions
    cart_item
  end

  def remove_item(item)
    cart_item = cart_items.find_by(item: item)
    cart_item&.destroy

    PromotionEngine.new(self).apply_best_promotions
  end

  def total_price
    cart_items.sum(&:final_price_cents).to_f / 100
  end
end
