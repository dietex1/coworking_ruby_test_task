class Reservation < ApplicationRecord
  belongs_to :room

  validates :guest_name, :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :capacity_not_exceeded, if: -> { start_date.present? && end_date.present? && room.present? }

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
  def capacity_not_exceeded
    overlapping = room.reservations.where.not(id: id).where(
      "start_date < ? AND end_date > ?", end_date, start_date
    ).to_a

    return if overlapping.size < room.capacity

    events = [
      [start_date, 1],
      [end_date, -1]
    ]

    overlapping.each do |res|
      events << [res.start_date, 1]
      events << [res.end_date, -1]
    end

    events.sort!

    visitors_count = 0

    events.each do |time, action|
      visitors_count += action

      if visitors_count > room.capacity
        errors.add(:base, "Room capacity exceeded at #{time.strftime('%H:%M')}")
        break
      end
    end
  end
end