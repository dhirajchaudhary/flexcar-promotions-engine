# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :promotion_application, optional: true

  has_one :promotion, through: :promotion_application
  has_one :promotion_application, dependent: :destroy

  def total_weight_grams
    return weight_grams if item.weight?
    quantity * item.weight_per_unit_grams.to_i
  end

  def final_price_cents
    if promotion_application
      promotion_application.discounted_price_cents
    elsif item.quantity?
      item.price_cents * quantity.to_i
    else
      (item.price_cents * weight_grams.to_f / 100).to_i  # Price per 100g × grams
    end
  end
end