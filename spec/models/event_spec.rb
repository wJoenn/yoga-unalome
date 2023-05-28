require "rails_helper"

def test_wrong_event(params = {})
  wrong_event = Event.create(params)
  expect(wrong_event.persisted?).to be_falsy
end

RSpec.describe Event, type: :model do
  let!(:start_time) { 1.hour.from_now }
  let!(:duration) { 90 }
  let!(:address) { "LLN" }
  let!(:capacity) { 9 }
  let!(:price) { 12 }
  let!(:event) { Event.create(start_time:, duration:, address:, capacity:, price:) }

  describe "validations" do
    it "requires a starting time, an ending time, an address and a capacity" do
      expect(event.persisted?).to be_truthy

      Event.destroy_all
      test_wrong_event(start_time:, duration:, capacity:, price:)
      test_wrong_event(start_time:, address:, capacity:, price:)
      test_wrong_event(duration:, address:, capacity:, price:)
      test_wrong_event(duration:, address:, capacity:, price:)
    end

    it "requires to have a different time span than other events" do
      test_wrong_event(start_time:, duration:, address:, capacity:, price:)
    end

    it "requires the start time to not be sooner than now" do
      Event.destroy_all
      test_wrong_event(start_time: 1.day.ago, duration:, address:, capacity:, price:)
    end

    it "requires to have a positive integer for duration" do
      Event.destroy_all
      test_wrong_event(start_time:, duration: -90, address:, capacity:, price:)
      test_wrong_event(start_time:, duration: 90.5, address:, capacity:, price:)
    end

    it "requires to have a positive integer for price" do
      Event.destroy_all
      test_wrong_event(start_time:, duration:, address:, capacity:, price: -12)
      test_wrong_event(start_time:, duration:, address:, capacity:, price_cents: 12.5)
    end
  end

  describe "associations" do
    it "has many Bookings" do
      user = User.create(email: "user@example.com", password: "password", first_name: "louis", last_name: "ramos")
      2.times { Booking.create(user:, event:) }

      expect(event.bookings).to all be_a Booking
    end
  end

  describe "self#upcoming" do
    it "returns a ActiveRecord relation array of Event" do
      coming_events = Event.upcoming
      expect(coming_events).to all be_an Event
    end
  end

  describe "#day" do
    it "returns the event's start_time as a date" do
      expect(event.start_time).not_to be_a Date
      expect(event.day).to be_a Date
    end
  end
end
