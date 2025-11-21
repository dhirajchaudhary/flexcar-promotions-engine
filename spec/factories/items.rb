FactoryBot.define do
  factory :item do
    name { "MyString" }
    price_cents { 1 }
    unit { 1 }
    weight_per_unit_grams { 1 }
    category { nil }
    brand { nil }
  end
end
