# db/seeds.rb  ← This is 100% correct
electronics = Category.create!(name: "Electronics")
fruits = Category.create!(name: "Fruits")

apple = Item.create!(
  name: "Granny Smith Apple",
  price_cents: 149,
  unit: :weight,
  weight_per_unit_grams: 200,
  category: fruits
)

laptop = Item.create!(
  name: "MacBook Pro",
  price_cents: 199_900,
  unit: :quantity,
  category: electronics
)

Promotion.create!(
  name: "20% off all Electronics",
  discount_type: :percentage,
  discount_value: 20,
  category: electronics,
  start_time: 1.day.ago
)

Promotion.create!(
  name: "Buy 2 Get 1 Free Apples",
  discount_type: :buy_x_get_y,
  buy_quantity: 2,
  get_quantity: 1,
  item: apple,
  start_time: 1.day.ago
)

puts "Seeded successfully!"