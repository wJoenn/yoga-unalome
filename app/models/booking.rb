class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user

  monetize :amount_cents

  before_create :set_amount

  validates :status, inclusion: { in: %w[pending confirmed canceled] }

  def canceled?
    status == "canceled"
  end

  private

  def set_amount
    self.amount_cents = event.price_cents
  end
end
