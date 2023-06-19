require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :request do
  # let!(:auth) do
  #   OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
  #     provider: "facebook",
  #     uid: "10",
  #     info: { email: "user@example.com", name: "First Last" }
  #   )
  # end

  describe "GET #facebook" do
    it "creates a new User" do
      OmniAuth.config.test_mode = true
      auth = OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: "facebook",
        uid: "10",
        info: { email: "user@example.com", name: "First Last" }
      )

      get(user_facebook_omniauth_callback_path,
        env: { "devise.mapping": Devise.mappings[:user], "omniauth.auth": auth })

      expect(User.last.uid).to eq "10"
    end

    it "finds a User" do
      user = User.create(email: "user@example.com", password: "password", first_name: "First", last_name: "Last")
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: "facebook",
        uid: "10",
        info: { email: "user@example.com", name: "First Last" }
      )

      get(user_facebook_omniauth_callback_path,
        env: { "devise.mapping": Devise.mappings[:user], "omniauth.auth": OmniAuth.config.mock_auth[:facebook] })

      expect(controller.view_assigns["user"].id).to eq user.id
    end

    it "redirects" do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: "facebook",
        uid: "10",
        info: { email: "userexample.com", name: "First Last" }
      )

      get(user_facebook_omniauth_callback_path,
        env: { "devise.mapping": Devise.mappings[:user], "omniauth.auth": OmniAuth.config.mock_auth[:facebook] })

      expect(response.location).to eq "http://www.example.com/users/sign_up"
    end
  end
end
