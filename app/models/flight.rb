class Flight < ApplicationRecord
  belongs_to :airline
  belongs_to :origin_airport, class_name: "Airport"
  belongs_to :destination_airport, class_name: "Airport"

  has_many :flight_instances, dependent: :destroy

  validates :flight_number, presence: true, uniqueness: { scope: :airline_id }
  validates :origin_airport, presence: true
  validates :destination_airport, presence: true

  validate :origin_and_destination_must_differ

  private

  def origin_and_destination_must_differ
    return if origin_airport_id.blank? || destination_airport_id.blank?
    return unless origin_airport_id == destination_airport_id

    errors.add(:destination_airport_id, "must differ from origin_airport_id")
  end
end
