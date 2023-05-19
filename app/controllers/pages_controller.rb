class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    @events = Event.coming.map(&:day).to_json
    @event_cards = Event.coming
  end
end
