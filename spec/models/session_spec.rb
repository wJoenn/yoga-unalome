require "rails_helper"

def test_wrong_session(params = {})
  wrong_session = Session.create(params)
  expect(wrong_session.persisted?).to be_falsy
end

RSpec.describe Session, type: :model do
  let!(:start_time) { Time.current }
  let!(:end_time) { 1.hour.from_now }
  let!(:address) { "Louvain La Neuve" }
  let!(:capacity) { 9 }
  let!(:session) { Session.create(start_time:, end_time:, address:, capacity:) }

  describe "validation" do
    it "requires a starting time, an ending time, an address and a capacity" do
      expect(session.persisted?).to be_truthy

      test_wrong_session(start_time:, end_time:, address:)
      test_wrong_session(start_time:, end_time:, capacity:)
      test_wrong_session(start_time:, address:, capacity:)
      test_wrong_session(end_time:, address:, capacity:)
    end

    it "requires to have a different time span than other sessions" do
      test_wrong_session(start_time:, end_time:, address:, capacity:)
    end
  end
end
