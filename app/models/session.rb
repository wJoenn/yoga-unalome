class Session < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :start_time, :end_time, :address, :capacity, presence: true
  validate :available_time_span, if: :presence_confirmed?
  validate :start_time_before_end_time, if: :presence_confirmed?
  validate :not_sooner_than_now, if: :presence_confirmed?

  def self.coming
    Session.where("start_time > ?", Time.current)
  end

  def day
    start_time.to_date
  end

  private

  def available_time_span
    sessions = Session.coming
    sessions = sessions.reject { |session| session.id == id }
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

  def not_sooner_than_now
    return if start_time > Time.current

    errors.add(:start_time, "cannot be sooner than now")
  end

  def presence_confirmed?
    start_time.present? && end_time.present?
  end

  def start_time_before_end_time
    return if end_time > start_time

    errors.add(:end_time, "cannot be sooner than the start")
  end
end
