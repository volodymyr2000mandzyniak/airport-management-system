class GateAssignment < ApplicationRecord
  belongs_to :flight_instance
  belongs_to :gate

  validates :flight_instance, :gate, :active_from, :active_to, presence: true

  validate :active_range_valid
  validate :no_overlapping_assignments

  private

  def active_range_valid
    return if active_from.blank? || active_to.blank?
    return if active_to > active_from

    errors.add(:active_to, "must be after active_from")
  end

  def no_overlapping_assignments
    return if gate_id.blank? || active_from.blank? || active_to.blank?
    return if errors[:active_to].present? # щоб не дублювати помилки, якщо range invalid

    overlap = self.class
      .where(gate_id: gate_id)
      .where.not(id: id)
      .where(
        "tsrange(active_from, active_to, '[)') && tsrange(?, ?, '[)')",
        active_from, active_to
      )
      .exists?

    if overlap
      errors.add(:base, "Gate is already assigned to another flight instance for the selected time range")
    end
  end
end
