require "rails_helper"

RSpec.describe SessionsController, type: :request do
  let!(:start_time) { 1.hour.from_now }
  let!(:duration) { 90 }
  let!(:address) { "Louvain La Neuve" }
  let!(:capacity) { 9 }
  let!(:session) { Session.create(start_time:, duration:, address:, capacity:) }
  let!(:count) { Session.count }
  let!(:user) { User.create(email: "user@example.com", password: "password", first_name: "Louis", last_name: "Ramos") }

  describe "#authenticate_user!" do
    it "requires authentification for #create" do
      post sessions_path
      expect(response).to have_http_status(:found)
    end

    it "requires authentification for #update" do
      put session_path(session)
      expect(response).to have_http_status(:found)
    end

    it "requires authentification for #destroy" do
      delete session_path(session)
      expect(response).to have_http_status(:found)
    end
  end

  describe "#create" do
    before do
      sign_in user
    end

    it "creates a new instance of Session with proper params" do
      params = { session: { start_time: 3.hours.from_now, duration: 90, address:, capacity: } }
      post(sessions_path, params:)

      expect(Session.count).to eq(count + 1)
    end

    it "returns a http status of 422 with unproper params" do
      params = { session: { start_time: nil, duration: nil, address: nil, capacity: nil } }
      post(sessions_path, params:)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "#update" do
    before do
      sign_in user
    end

    it "updates an instance of Session with proper params" do
      patch(session_path(session), params: { session: { capacity: 10 } })
      updated_session = Session.find(session.id)

      expect(updated_session.capacity).to eq(10)
    end

    it "returns a http status of 422 with unproper params" do
      patch(session_path(session), params: { session: { start_time: 1.hour.ago } })
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "#destroy" do
    it "destroys the Session instance" do
      sign_in user
      delete(session_path(session))

      expect(Session.count).to eq(count - 1)
    end
  end
end
