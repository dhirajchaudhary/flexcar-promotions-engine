class CreatePromotionApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :promotion_applications do |t|
      t.references :promotion, null: false, foreign_key: true
      t.references :cart_item, null: false, foreign_key: true
      t.integer :applied_quantity, default: 0
      t.integer :original_price_cents, null: false, default: 0
      t.integer :discounted_price_cents, null: false, default: 0

      t.timestamps
    end
  end
end
