class Seat < ApplicationRecord
  belongs_to :aircraft

  enum :cabin_class, { economy: 0, business: 1, first: 2 }, prefix: true

  validates :aircraft, presence: true
  validates :seat_number, presence: true, uniqueness: { scope: :aircraft_id }
  validates :cabin_class, presence: true
end
