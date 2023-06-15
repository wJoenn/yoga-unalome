class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user

  monetize :amount_cents

  before_create :set_amount

  validates :status, inclusion: { in: %w[pending confirmed canceled refunded] }

  def canceled?
    status == "canceled"
  end

  def refunded?
    status == "refunded"
  end

  def upcoming?
    event.start_time > Time.current
  end

  private

  def set_amount
    self.amount_cents = event.price_cents
  end
end
