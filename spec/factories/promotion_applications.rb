FactoryBot.define do
  factory :promotion_application do
    promotion { nil }
    cart_item { nil }
    applied_quantity { 1 }
    original_price_cents { 1 }
    discounted_price_cents { 1 }
  end
end
