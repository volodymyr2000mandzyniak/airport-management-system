class FlightInstance < ApplicationRecord
  belongs_to :flight
  belongs_to :aircraft

  has_many :gate_assignments, dependent: :destroy
  has_many :check_in_assignments, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :tickets, dependent: :destroy

  enum :status, {
    scheduled: 0,
    boarding: 1,
    departed: 2,
    arrived: 3,
    delayed: 4,
    cancelled: 5
  }

  validates :scheduled_departure_at, presence: true
  validates :scheduled_arrival_at, presence: true
  validates :status, presence: true
  validates :aircraft, presence: true
  validates :flight, presence: true

  validate :scheduled_times_order
  validate :actual_times_order
  validate :actual_times_not_before_scheduled
  validate :actual_times_presence_by_status

  private

  def scheduled_times_order
    return if scheduled_departure_at.blank? || scheduled_arrival_at.blank?
    return if scheduled_arrival_at > scheduled_departure_at

    errors.add(:scheduled_arrival_at, "must be after scheduled_departure_at")
  end

  def actual_times_order
    return if actual_departure_at.blank? || actual_arrival_at.blank?
    return if actual_arrival_at > actual_departure_at

    errors.add(:actual_arrival_at, "must be after actual_departure_at")
  end

  def actual_times_not_before_scheduled
    if actual_departure_at.present? && scheduled_departure_at.present? && actual_departure_at < scheduled_departure_at
      errors.add(:actual_departure_at, "cannot be earlier than scheduled_departure_at")
    end

    if actual_arrival_at.present? && scheduled_arrival_at.present? && actual_arrival_at < scheduled_arrival_at
      errors.add(:actual_arrival_at, "cannot be earlier than scheduled_arrival_at")
    end
  end

  # Не обов'язково, але дуже логічно для доменної моделі:
  # - якщо статус departed/arrived → має бути actual_departure_at
  # - якщо статус arrived → має бути actual_arrival_at
  def actual_times_presence_by_status
    if (departed? || arrived?) && actual_departure_at.blank?
      errors.add(:actual_departure_at, "must be present when status is departed or arrived")
    end

    if arrived? && actual_arrival_at.blank?
      errors.add(:actual_arrival_at, "must be present when status is arrived")
    end
  end
end
