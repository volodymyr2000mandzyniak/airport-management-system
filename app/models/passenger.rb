class Passenger < ApplicationRecord
  has_many :tickets, dependent: :restrict_with_error

  validates :first_name, :last_name, :document_number, presence: true
  validates :document_number, uniqueness: true
end
