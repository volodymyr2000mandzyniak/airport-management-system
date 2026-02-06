class Ticket < ApplicationRecord
  belongs_to :booking
  belongs_to :passenger
  belongs_to :flight_instance
  belongs_to :seat

  has_one :boarding_pass, dependent: :destroy, autosave: false
  has_many :baggages, dependent: :destroy

  validates :booking, :passenger, :flight_instance, :seat, presence: true
  validates :seat_id, uniqueness: { scope: :flight_instance_id }

  validate :flight_instance_matches_booking
  validate :seat_belongs_to_flight_aircraft

  before_validation :sync_flight_instance_from_booking, if: -> { booking.present? && flight_instance.blank? }

  private

  def sync_flight_instance_from_booking
    self.flight_instance = booking.flight_instance
  end

  def flight_instance_matches_booking
    return if booking.blank? || flight_instance.blank?
    return if booking.flight_instance_id == flight_instance_id

    errors.add(:flight_instance, "must match booking.flight_instance")
  end

  def seat_belongs_to_flight_aircraft
    return if seat.blank? || flight_instance.blank? || flight_instance.aircraft_id.blank?

    if seat.aircraft_id != flight_instance.aircraft_id
      errors.add(:seat, "must belong to the aircraft assigned to this flight instance")
    end
  end
end
