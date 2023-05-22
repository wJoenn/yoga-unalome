require "rails_helper"

RSpec.describe BookingsController, type: :request do
  describe "#create" do
    it "creates a new instance of Booking with proper params" do
      params = { event: { start_time: 3.hours.from_now, duration: 90, address:, capacity: } }
    end
  end
end
