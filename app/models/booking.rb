class Booking < ApplicationRecord
  belongs_to :flight_instance
  has_many :tickets, dependent: :destroy

  validates :pnr, presence: true, uniqueness: true
  validates :flight_instance, presence: true
end
