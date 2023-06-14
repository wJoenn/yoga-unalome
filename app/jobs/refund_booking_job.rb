class RefundBookingJob < ApplicationJob
  queue_as :default

  def perform(booking)
    checkout_session = Stripe::Checkout::Session.retrieve(booking.checkout_session_id)
    amount = booking.event.day > Time.zone.today ? booking.amount_cents : booking.amount_cents / 2

    Stripe::Refund.create({
      payment_intent: checkout_session.payment_intent,
      amount:
    })
  end
end
