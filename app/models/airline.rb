class Airline < ApplicationRecord
  has_many :aircrafts, dependent: :destroy
  has_many :flights, dependent: :destroy

  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
