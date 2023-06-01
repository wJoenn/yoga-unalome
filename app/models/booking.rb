class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user

  monetize :amount_cents

  validates :canceled, inclusion: { in: [true, false] }

  def canceled?
    canceled
  end
end
