class Transaction < ApplicationRecord
  belongs_to :recipient_id
  belongs_to :payer_id
end
