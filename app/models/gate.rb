class Gate < ApplicationRecord
  belongs_to :terminal

  validates :code, presence: true, uniqueness: { scope: :terminal_id }
end
