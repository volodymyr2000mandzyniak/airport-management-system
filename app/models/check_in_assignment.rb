class CheckInAssignment < ApplicationRecord
  belongs_to :flight_instance
  belongs_to :check_in_counter

  validates :flight_instance, :check_in_counter, :active_from, :active_to, presence: true

  validate :active_range_valid
  validate :no_overlapping_assignments

  private

  def active_range_valid
    return if active_from.blank? || active_to.blank?
    return if active_to > active_from

    errors.add(:active_to, "must be after active_from")
  end

  def no_overlapping_assignments
    return if check_in_counter_id.blank? || active_from.blank? || active_to.blank?
    return if errors[:active_to].present?

    overlap = self.class
      .where(check_in_counter_id: check_in_counter_id)
      .where.not(id: id)
      .where(
        "tsrange(active_from, active_to, '[)') && tsrange(?, ?, '[)')",
        active_from, active_to
      )
      .exists?

    if overlap
      errors.add(:base, "Check-in counter is already assigned to another flight instance for the selected time range")
    end
  end
end
