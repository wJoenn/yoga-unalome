require "rails_helper"

def test_wrong_transaction(**params)
  wrong_transaction = Transaction.create(params)
  expect(wrong_transaction.persisted?).to be_falsy
end

RSpec.describe Transaction, type: :model do
  let!(:password) { "password" }
  let!(:payer) { User.create(email: "payer@example.com", password:, first_name: "Louis", last_name: "Ramos") }
  let!(:payer_name) { payer.full_name }
  let!(:recipient) { User.create(email: "recipient@example.com", password:, first_name: "Chloe", last_name: "Aberg") }
  let!(:recipient_name) { recipient.full_name }
  let!(:transaction) { Transaction.create(payer:, recipient:, payer_name:, recipient_name:) }

  describe "validations" do
    it "requires a payer and a recipient" do
      expect(transaction.persisted?).to be_truthy

      test_wrong_transaction(payer:, recipient:, payer_name:)
      test_wrong_transaction(payer:, recipient:, recipient_name:)
      test_wrong_transaction(payer:, payer_name:, recipient_name:)
      test_wrong_transaction(recipient:, payer_name:, recipient_name:)
    end
  end

  describe "associations" do
    it "belongs to a payer User" do
      expect(transaction.payer).to be_a User
    end

    it "belongs to a recipient User" do
      expect(transaction.recipient).to be_a User
    end

    it "is not dependent on either User" do
      id = transaction.id

      payer.destroy
      recipient.destroy
      expect(Transaction.find_by(id:)).to be_present
    end
  end

  describe "date" do
    it "returns a string of the date of creation" do
      today = Date.current.strftime("%Y/%m/%d")
      expect(transaction.date).to eq today
    end
  end
end
