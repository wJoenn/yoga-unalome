require "rails_helper"

RSpec.describe UserDashboardController, type: :request do
  let!(:start_time) { 1.hour.from_now }
  let!(:duration) { 90 }
  let!(:address) { "Louvain La Neuve" }
  let!(:capacity) { 9 }
  let!(:price) { 12 }
  let!(:title) { "Vinyasa Flow" }
  let!(:event) { Event.create(start_time:, duration:, address:, capacity:, price:, title:) }

  let(:password) { "password" }
  let(:first_name) { "Chloe" }
  let(:last_name) { "Aberg" }
  let!(:user) { User.create(email: "info@yogaunalome.com", password:, first_name:, last_name:) }

  describe "#authenticate_user!" do
    it "requires authentification for #show" do
      get dashboard_path
      expect(response).to have_http_status(:found)
    end
  end

  describe "#new" do
    before do
      sign_in user
    end

    it "stores the user's bookings in a variable" do
      Booking.create(event:, user:)
      get dashboard_path

      expect(controller.view_assigns["bookings"].first).to be_a Booking
    end
  end
end
