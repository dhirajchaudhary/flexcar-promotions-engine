class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.string :name, null: false
      t.integer :discount_type, null: false, default: 0
      t.decimal :discount_value, precision: 8, scale: 2
      t.integer :buy_quantity
      t.integer :get_quantity
      t.integer :threshold_grams

      t.references :item,     null: true, foreign_key: true
      t.references :category, null: true, foreign_key: true

      t.datetime :start_time, null: false
      t.datetime :end_time

      t.timestamps
    end
  end
end
