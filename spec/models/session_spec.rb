require "rails_helper"

def test_wrong_session(params = {})
  wrong_session = Session.create(params)
  expect(wrong_session.persisted?).to be_falsy
end

RSpec.describe Session, type: :model do
  let!(:start_time) { 1.hour.from_now }
  let!(:duration) { 90 }
  let!(:address) { "Louvain La Neuve" }
  let!(:capacity) { 9 }
  let!(:session) { Session.create(start_time:, duration:, address:, capacity:) }

  describe "validation" do
    it "requires a starting time, an ending time, an address and a capacity" do
      expect(session.persisted?).to be_truthy

      test_wrong_session(start_time:, duration:, address:)
      test_wrong_session(start_time:, duration:, capacity:)
      test_wrong_session(start_time:, address:, capacity:)
      test_wrong_session(duration:, address:, capacity:)
    end

    it "requires to have a different time span than other sessions" do
      test_wrong_session(start_time:, duration:, address:, capacity:)
    end

    it "requires the start time to not be sooner than now" do
      test_wrong_session(start_time: 1.day.ago, duration:, address:, capacity:)
    end

    it "requires to have a positive integer for duration" do
      test_wrong_session(start_time:, duration: -90, address:, capacity:)
      test_wrong_session(start_time:, duration: 90.5, address:, capacity:)
    end
  end

  describe "association" do
    it "has many Bookings" do
      user = User.create(email: "user@example.com", password: "password", first_name: "louis", last_name: "ramos")
      2.times { Booking.create(user:, session:) }

      expect(session.bookings).to all be_a Booking
    end
  end
end
