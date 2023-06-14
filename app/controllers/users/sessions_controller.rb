class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)

    add_uid_to_user(resource) if uid?

    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def add_uid_to_user(resource)
    user_params = params.require(:user).permit(:uid)
    resource.update(uid: user_params[:uid], provider: "facebook")
  end

  def uid?
    params[:user].key?(:uid)
  end
end
