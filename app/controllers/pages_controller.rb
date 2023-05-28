class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    @events_dates = Event.upcoming.map(&:day).to_json
    @events = Event.upcoming
  end
end
