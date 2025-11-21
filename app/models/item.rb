class Item < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  has_many :cart_items, dependent: :destroy

  enum :unit, { quantity: 0, weight: 1 }

  validates :name, :price_cents, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
end
