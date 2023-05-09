require "rails_helper"

def test_wrong_booking(params = {})
  wrong_booking = Booking.create(params)
  expect(wrong_booking.persisted?).to be_falsy
end

RSpec.describe Booking, type: :model do
  let(:session) do
    Session.create(start_time: 1.hour.from_now, duration: 90, address: "Almaty", capacity: 7)
  end
  let(:user) { User.create(email: "user@example.com", password: "password", first_name: "louis", last_name: "ramos") }
  let!(:booking) { Booking.create(user:, session:) }

  describe "validation" do
    it "requires a user and a session" do
      expect(booking.persisted?).to be_truthy

      test_wrong_booking(session:)
      test_wrong_booking(user:)
    end
  end

  describe "association" do
    it "belongs to a Session" do
      expect(booking.session).to be_a Session
    end

    it "belongs to a User" do
      expect(booking.user).to be_a User
    end
  end

  describe "instance methods" do
    it "sets the booking as not canceled by default" do
      expect(booking.canceled?).to be_falsy
    end
  end
end
