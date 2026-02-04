class Airport < ApplicationRecord
  has_many :terminals, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  validates :iata_code, uniqueness: true, allow_nil: true
  validates :icao_code, uniqueness: true, allow_nil: true
end
