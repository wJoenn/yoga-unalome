require "rails_helper"

def test_wrong_user(params = {})
  wrong_user = User.create(params)
  expect(wrong_user.persisted?).to be_falsy
end

RSpec.describe User, type: :model do
  let!(:email) { "user@example.com" }
  let!(:password) { "password" }
  let!(:first_name) { "louis" }
  let!(:last_name) { "ramos" }
  let!(:user) { User.create(email:, password:, first_name:, last_name:) }
  let!(:event) do
    Event.create(start_time: 1.hour.from_now, duration: 90, address: "LLN", capacity: 9, price: 12, title: "Vinyasa")
  end

  describe "validation" do
    it "requires an email adress, a password, a first name and a last name" do
      expect(user.persisted?).to be_truthy

      user.destroy
      test_wrong_user(email:, password:, first_name:)
      test_wrong_user(email:, password:, last_name:)
      test_wrong_user(email:, first_name:, last_name:)
      test_wrong_user(password:, first_name:, last_name:)
    end

    it "requires a unique email" do
      test_wrong_user(email:, password:, first_name:, last_name:)
    end

    it "requires a valid email address" do
      user.destroy
      test_wrong_user(email: "user@example", password:, first_name:, last_name:)
      test_wrong_user(email: "user.example.com", password:, first_name:, last_name:)
      test_wrong_user(email: "user@example.c", password:, first_name:, last_name:)
    end
  end

  describe "association" do
    it "has many Bookings" do
      2.times { Booking.create(user:, event:) }

      expect(user.bookings).to all be_a Booking
    end
  end

  describe "self.from_omniauth" do
    it "creates a new User" do
      auth = OmniAuth::AuthHash.new(
        provider: "facebook",
        uid: "10",
        info: { email: "omni@example.com", name: "First Last" }
      )

      User.from_omniauth(auth)
      expect(User.last.uid).to eq "10"
    end

    it "returns an existing User and a uid" do
      auth = OmniAuth::AuthHash.new(
        provider: "facebook",
        uid: "10",
        info: { email: "user@example.com", name: "First Last" }
      )

      omniauth_user, uid = User.from_omniauth(auth)
      expect(omniauth_user).to eq user
      expect(uid).to eq "10"
    end
  end

  describe "instance methods" do
    it "sets the value of admin to false by default" do
      expect(user.admin?).to be_falsy
    end

    it "capitalize the user's names when created" do
      expect(user.first_name).to eq("Louis")
      expect(user.last_name).to eq("Ramos")
    end

    it "returns the user's full name" do
      expect(user.full_name).to eq("Louis Ramos")
    end
  end
end
