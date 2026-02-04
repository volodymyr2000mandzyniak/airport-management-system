class Aircraft < ApplicationRecord
  belongs_to :airline
  has_many :seats, dependent: :destroy

  validates :airline, presence: true
  validates :model, presence: true
  validates :registration_number, presence: true, uniqueness: true
end
