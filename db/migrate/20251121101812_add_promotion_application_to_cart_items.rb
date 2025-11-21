class AddPromotionApplicationToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :cart_items, :promotion_application, foreign_key: true, null: true
  end
end
