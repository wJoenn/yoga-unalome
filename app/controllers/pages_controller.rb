class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    @sessions = Session.coming.map(&:day).to_json
  end
end
