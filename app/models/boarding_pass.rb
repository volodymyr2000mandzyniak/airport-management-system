class BoardingPass < ApplicationRecord
  belongs_to :ticket

  before_validation :set_issued_at, on: :create

  validates :issued_at, presence: true
  validates :ticket_id, uniqueness: true

  validate :ticket_must_be_checked_in
  validate :ticket_must_have_seat

  private

  def set_issued_at
    self.issued_at ||= Time.current
  end

  def ticket_must_be_checked_in
    return if ticket&.checked_in_at.present?
    errors.add(:ticket, "must be checked in before boarding pass can be issued")
  end

  def ticket_must_have_seat
    return if ticket&.seat_id.present?
    errors.add(:ticket, "must have a seat assigned before boarding pass can be issued")
  end
end
