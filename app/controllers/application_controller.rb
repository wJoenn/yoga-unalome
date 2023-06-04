class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_contact
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :admin_user?

  def admin_user?
    current_user&.admin?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  private

  def set_contact
    @contact = Contact.new
  end
end
