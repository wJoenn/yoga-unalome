class Transaction < ApplicationRecord
  belongs_to :payer, class_name: "User"
  belongs_to :recipient, class_name: "User"

  monetize :amount_cents

  validates :payer_name, :recipient_name, presence: true

  def date
    created_at.strftime("%Y/%m/%d")
  end
end
