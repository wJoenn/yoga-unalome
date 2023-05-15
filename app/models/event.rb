class Event < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :start_time, :duration, :address, :capacity, presence: true
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :available_time_span, if: :presence_confirmed?
  validate :not_sooner_than_now, if: :presence_confirmed?

  def self.coming
    Event.where("start_time > ?", Time.current)
  end

  def day
    start_time.to_date
  end

  def end_time
    start_time + (duration * 60)
  end

  private

  def available_time_span
    events = Event.coming
    events = events.reject { |event| event.id == id }
    return unless events.any?

    times = events.pluck(:start_time, :duration).map do |event|
      event_start = event.first
      event_end = event_start + (event.last * 60)

      hour_range(event_start, event_end)
    end

    return unless times.flatten.intersect?(hour_range(start_time, end_time))

    errors.add(:start_time, :taken, message: "You already have an event at that time")
  end

  def hour_range(start, ending)
    start = start.to_i.fdiv(60 * 30).floor
    ending = ending.to_i.fdiv(60 * 30).floor

    (start..ending).to_a
  end

  def not_sooner_than_now
    return if start_time > Time.current

    errors.add(:start_time, "cannot be sooner than now")
  end

  def presence_confirmed?
    start_time.present? && duration.present?
  end
end
