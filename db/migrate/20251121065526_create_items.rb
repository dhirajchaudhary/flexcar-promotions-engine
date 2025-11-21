class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price_cents, null: false, default: 0
      t.integer :unit, null: false, default: 0
      t.integer :weight_per_unit_grams, default: 0
      t.references :category, null: true, foreign_key: true
      t.references :brand, null: true, foreign_key: true

      t.timestamps
    end
  end
end
