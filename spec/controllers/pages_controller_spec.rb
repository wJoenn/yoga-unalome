require "rails_helper"

RSpec.describe PagesController, type: :request do
  let!(:start_time) { 1.hour.from_now }
  let!(:duration) { 90 }
  let!(:address) { "Louvain La Neuve" }
  let!(:capacity) { 9 }
  let!(:price) { 12 }
  let!(:title) { "Vinyasa Flow" }
  let!(:event) { Event.create(start_time:, duration:, address:, capacity:, price:, title:) }

  describe "#home" do
    it "initialize a list of upcoming events" do
      get root_path

      expect(controller.view_assigns["events"].first).to be_an Event
    end

    it "initialize a list of upcoming events dates as json" do
      get root_path

      expect(controller.view_assigns["events_dates"]).to be_a String

      data = JSON.parse(controller.view_assigns["events_dates"])
      expect(data).to be_an Array
      expect(data.first).to match(/\d{4}(?:-\d{2}){2}/)
    end
  end
end
