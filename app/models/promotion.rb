class Promotion < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :category, optional: true
  has_many :promotion_applications, dependent: :destroy

  enum :discount_type, {
    percentage: 0,
    flat: 1,
    buy_x_get_y: 2,
    weight_threshold: 3
  }

  scope :active, ->(time = Time.current) {
    where("start_time <= ?", time)
      .where("end_time IS NULL OR end_time >= ?", time)
  }

  validates :name, :start_time, :discount_type, presence: true
end
