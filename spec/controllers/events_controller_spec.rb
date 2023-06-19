require "rails_helper"

RSpec.describe EventsController, type: :request do
  let!(:start_time) { 1.hour.from_now }
  let!(:duration) { 90 }
  let!(:address) { "Louvain La Neuve" }
  let!(:capacity) { 9 }
  let!(:price) { 12 }
  let!(:title) { "Vinyasa Flow" }
  let!(:event) { Event.create(start_time:, duration:, address:, capacity:, price:, title:) }
  let!(:count) { Event.count }

  let(:password) { "password" }
  let(:first_name) { "Chloe" }
  let(:last_name) { "Aberg" }
  let!(:user) { User.create(email: "info@yogaunalome.com", password:, first_name:, last_name:) }
  let!(:admin) { User.create(email: "admin@yogaunalome.com", password:, first_name:, last_name:, admin: true) }

  describe "#redirect_unless_admin" do
    it "requires authentification by an admin for #new" do
      get new_event_path
      expect(response).to have_http_status(:found)

      sign_in user
      expect(response).to have_http_status(:found)
    end

    it "requires authentification by an admin for #create" do
      post events_path
      expect(response).to have_http_status(:found)

      sign_in user
      expect(response).to have_http_status(:found)
    end

    it "requires authentification by an admin for #update" do
      put event_path(I18n.locale, event)
      expect(response).to have_http_status(:found)

      sign_in user
      expect(response).to have_http_status(:found)
    end

    it "requires authentification by an admin for #destroy" do
      delete event_path(I18n.locale, event)
      expect(response).to have_http_status(:found)

      sign_in user
      expect(response).to have_http_status(:found)
    end
  end

  describe "#new" do
    before do
      sign_in admin
    end

    it "initialize a new instance of Event" do
      get new_event_path
      expect(controller.view_assigns["event"]).to be_a_new Event
    end
  end

  describe "#create" do
    before do
      sign_in admin
    end

    it "creates a new instance of Event with proper params" do
      params = { event: { start_time: 3.hours.from_now, duration: 90, address:, capacity:, price:, title: } }
      post(events_path, params:)

      expect(response).to have_http_status :ok
      expect(Event.count).to eq(count + 1)
    end

    it "returns a http status of 422 with unproper params" do
      params = { event: { start_time: nil, duration: nil, address: nil, capacity: nil, price: nil } }
      post(events_path, params:)

      expect(response).to have_http_status :unprocessable_entity
    end
  end

  describe "#update" do
    before do
      sign_in admin
    end

    it "updates an instance of Event with proper params" do
      patch(event_path(I18n.locale, event), params: { event: { capacity: 10 } })
      updated_event = Event.find(event.id)

      expect(response).to have_http_status :ok
      expect(updated_event.capacity).to eq(10)
    end

    it "returns a http status of 422 with unproper params" do
      patch(event_path(I18n.locale, event), params: { event: { start_time: 1.hour.ago } })
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "#destroy" do
    it "destroys the Event instance" do
      sign_in admin
      delete(event_path(I18n.locale, event))

      expect(Event.count).to eq(count - 1)
    end
  end

  describe "#confirmation" do
    it "renders a booking_confirmation partial" do
      get(confirm_booking_event_path(I18n.locale, event))

      expect(response.body).to match(/booking-confirmation/)
    end
  end
end
