class Terminal < ApplicationRecord
  belongs_to :airport
  has_many :gates, dependent: :destroy
  has_many :check_in_counters, dependent: :destroy

  validates :code, presence: true, uniqueness: { scope: :airport_id }
  validates :name, presence: true
end
