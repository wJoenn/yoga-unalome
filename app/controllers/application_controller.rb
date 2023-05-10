class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :admin_user?

  def admin_user?
    current_user&.admin?
  end
end
