class Transaction < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :payer, class_name: "User"

  monetize :amount_cents

  def date
    created_at.strftime("%Y/%m/%d")
  end
end
