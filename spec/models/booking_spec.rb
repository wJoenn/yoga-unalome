require "rails_helper"

def test_wrong_booking(params = {})
  wrong_booking = Booking.create(params)
  expect(wrong_booking.persisted?).to be_falsy
end

RSpec.describe Booking, type: :model do
  let(:session) do
    Session.create(start_time: 1.hour.from_now, end_time: 2.hours.from_now, address: "Almaty", capacity: 7)
  end
  let(:user) { User.create(email: "user@example.com", password: "password", first_name: "louis", last_name: "ramos") }
  let!(:booking) { Booking.create(user_id: user.id, session_id: session.id, canceled: false) }

  describe "validation" do
    it "should persist a valid booking" do
      expect(booking.persisted?).to be_truthy
    end

    it "requires a user_id, a session_id, and a canceled status" do
      booking.destroy
      test_wrong_booking(user_id: nil, session_id: session.id, canceled: false)
      test_wrong_booking(user_id: user.id, session_id: nil, canceled: false)
      test_wrong_booking(user_id: user.id, session_id: session.id, canceled: nil)
    end
  end
end
