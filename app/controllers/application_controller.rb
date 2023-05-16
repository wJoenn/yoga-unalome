class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :new_contact

  private

  def new_contact
    @contact = Contact.new
  end
end
