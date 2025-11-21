FactoryBot.define do
  factory :cart_item do
    cart { nil }
    item { nil }
    quantity { 1 }
    weight_grams { 1 }
  end
end
