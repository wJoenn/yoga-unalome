require "rails_helper"

RSpec.describe Test, type: :model do
  it "fails the test" do
    test = Test.create
    expect(test.persisted?).to be_falsy
  end
end
