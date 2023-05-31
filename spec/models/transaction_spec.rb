require "rails_helper"

def test_wrong_transaction(**params)
  wrong_transaction = Transaction.create(params)
  expect(wrong_transaction.persisted?).to be_falsy
end

RSpec.describe Transaction, type: :model do
  let!(:password) { "password" }
  let!(:payer) { User.create(email: "payer@example.com", password:, first_name: "Louis", last_name: "Ramos") }
  let!(:recipient) { User.create(email: "recipient@example.com", password:, first_name: "Chloe", last_name: "Aberg") }
  let!(:transaction) { Transaction.create(payer:, recipient:) }

  describe "validations" do
    it "requires a payer and a recipient" do
      expect(transaction.persisted?).to be_truthy

      test_wrong_transaction(payer:)
      test_wrong_transaction(recipient:)
    end
  end

  describe "associations" do
    it "belongs to a payer User" do
      expect(transaction.payer).to be_a User
    end

    it "belongs to a recipient User" do
      expect(transaction.recipient).to be_a User
    end
  end

  describe "date" do
    it "returns a string of the date of creation" do
      today = Date.current.strftime("%Y/%m/%d")
      expect(transaction.date).to eq today
    end
  end
end
