class Airline < ApplicationRecord
  has_many :aircrafts, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
