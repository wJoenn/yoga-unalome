require "rails_helper"

RSpec.describe BookingsController, type: :request do
  let(:event) do
    Event.create(start_time: 1.hour.from_now, duration: 90, address: "Louvain La Neuve", capacity: 9, title: "Vinyasa")
  end
  let(:user) { User.create(email: "user@example.com", password: "password", admin: true) }

  # describe "#create" do
  #   before do
  #     sign_in user
  #   end
  #   context "with valid parameters" do
  #     it "creates a new booking" do
  #       post event_bookings_path(event), params: { booking: { user_id: user.id } }
  #       expect(response).to have_http_status(:redirect)
  #       expect(response).to redirect_to(root_path)
  #       expect(Booking.last.event).to eq(event)
  #       expect(Booking.last.user).to eq(user)
  #     end
  #   end
  # end
end
