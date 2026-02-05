class Gate < ApplicationRecord
  belongs_to :terminal
  has_many :gate_assignments, dependent: :destroy

  validates :terminal, presence: true
  validates :code, presence: true, uniqueness: { scope: :terminal_id }
end
