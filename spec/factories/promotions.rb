FactoryBot.define do
  factory :promotion do
    name { "MyString" }
    discount_type { 1 }
    discount_value { "9.99" }
    buy_quantity { 1 }
    get_quantity { 1 }
    threshold_grams { 1 }
    item { nil }
    category { nil }
    start_time { "2025-11-21 12:25:37" }
    end_time { "2025-11-21 12:25:37" }
  end
end
