class Gate < ApplicationRecord
  belongs_to :terminal

  validates :terminal, presence: true
  validates :code, presence: true, uniqueness: { scope: :terminal_id }
end
