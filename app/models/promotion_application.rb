class PromotionApplication < ApplicationRecord
  belongs_to :promotion
  belongs_to :cart_item, optional: true
end
