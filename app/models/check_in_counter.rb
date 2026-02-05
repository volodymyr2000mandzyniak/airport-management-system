class CheckInCounter < ApplicationRecord
  belongs_to :terminal
  has_many :check_in_assignments, dependent: :destroy

  validates :terminal, presence: true
  validates :code, presence: true, uniqueness: { scope: :terminal_id }
end
