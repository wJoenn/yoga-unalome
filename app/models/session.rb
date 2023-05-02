class Session < ApplicationRecord
  validates :start_time, :end_time, :address, :capacity, presence: true
  validate :available_time_span

  private

  def available_time_span
    sessions = Session.where("start_time > ?", 1.day.ago)
    return unless sessions.any?

    times = sessions.pluck(:start_time, :end_time).map do |range|
      hour_range(range.first, range.last)
    end

    return unless times.flatten.intersect?(hour_range(start_time, end_time))

    errors.add(:start_time, :taken, message: "You already have a session at that time")
  end

  def hour_range(start, ending)
    start = start.to_i.fdiv(60 * 30).floor
    ending = ending.to_i.fdiv(60 * 30).floor

    (start..ending).to_a
  end
end
