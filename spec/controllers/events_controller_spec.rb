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
  let!(:user) { User.create(email: "user@example.com", password: "password", admin: true) }

  before(:each) do
    user.confirm
  end

  describe "#authenticate_user!" do
    it "requires authentification for #create" do
      post events_path
      expect(response).to have_http_status(:found)
    end

    it "requires authentification for #update" do
      put event_path(event)
      expect(response).to have_http_status(:found)
    end

    it "requires authentification for #destroy" do
      delete event_path(event)
      expect(response).to have_http_status(:found)
    end
  end

  describe "#create" do
    before do
      sign_in user
    end

    it "creates a new instance of Event with proper params" do
      params = { event: { start_time: 3.hours.from_now, duration: 90, address:, capacity:, price:, title: } }
      post(events_path, params:)

      expect(Event.count).to eq(count + 1)
    end

    it "returns a http status of 422 with unproper params" do
      params = { event: { start_time: nil, duration: nil, address: nil, capacity: nil, price: nil } }
      post(events_path, params:)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "#update" do
    before do
      sign_in user
    end

    it "updates an instance of Event with proper params" do
      patch(event_path(event), params: { event: { capacity: 10 } })
      updated_event = Event.find(event.id)

      expect(updated_event.capacity).to eq(10)
    end

    it "returns a http status of 422 with unproper params" do
      patch(event_path(event), params: { event: { start_time: 1.hour.ago } })
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "#destroy" do
    it "destroys the Event instance" do
      sign_in user
      delete(event_path(event))

      expect(Event.count).to eq(count - 1)
    end
  end
end
