require "rails_helper"

RSpec.describe Users::SessionsController, type: :request do
  let(:email) { "info@yogaunalome.com" }
  let(:password) { "password" }
  let(:first_name) { "Chloe" }
  let(:last_name) { "Aberg" }
  let!(:user) { User.create(email:, password:, first_name:, last_name:) }

  describe "POST /create" do
    context "When there is a uid param" do
      it "adds the uid to the user" do
        post user_session_path,
          params: { user: { email:, password:, uid: "10" } },
          env: { "devise.mapping": Devise.mappings[:user] }

        expect(User.find(user.id).uid).to eq "10"
      end
    end
  end
end
