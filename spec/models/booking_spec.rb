require "rails_helper"

def test_wrong_booking(params = {})
  wrong_booking = Booking.create(params)
  expect(wrong_booking.persisted?).to be_falsy
end

RSpec.describe Booking, type: :model do
  let(:event) do
    Event.create(start_time: 1.hour.from_now, duration: 90, address: "LLN", capacity: 9, price: 12, title: "Vinyasa")
  end
  let(:user) { User.create(email: "user@example.com", password: "password", first_name: "louis", last_name: "ramos") }
  let!(:booking) { Booking.create(user:, event:) }

  describe "validation" do
    it "requires a User and an Event" do
      expect(booking.persisted?).to be_truthy

      test_wrong_booking(event:)
      test_wrong_booking(user:)
    end

    it "has an amount equivalent to its event's price" do
      expect(booking.amount).to eq event.price
    end

    it "had a default status of pending" do
      expect(booking.status).to eq "pending"
    end
  end

  describe "association" do
    it "belongs to an Event" do
      expect(booking.event).to be_a Event
    end

    it "belongs to a User" do
      expect(booking.user).to be_a User
    end
  end

  describe "#canceled?" do
    it "states whether a booking is canceled or not" do
      expect(booking.canceled?).to be_falsy

      booking.update(status: "canceled")
      expect(booking.canceled?).to be_truthy
    end
  end

  describe "#refunded?" do
    it "states whether a booking is refunded or not" do
      expect(booking.refunded?).to be_falsy

      booking.update(status: "refunded")
      expect(booking.refunded?).to be_truthy
    end
  end

  describe "#upcoming?" do
    it "states whether a booking is upcoming or not" do
      expect(booking.upcoming?).to be_truthy
    end
  end
end
