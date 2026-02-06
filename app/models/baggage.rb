class Baggage < ApplicationRecord
  belongs_to :ticket

  validates :ticket, presence: true
  validates :tag_number, presence: true, uniqueness: true
  validates :weight_kg, presence: true, numericality: { greater_than: 0 }
end
