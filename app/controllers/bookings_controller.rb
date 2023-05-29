class BookingsController < ApplicationController
  before_action :set_booking, only: %i[cancel]

  def create
    event = Event.find(params[:event_id])
    booking = event.bookings.new(amount: event.price, user: current_user)

    if booking.save
      customer = stripe_customer
      session = stripe_checkout_session(event, booking, customer)
      booking.update(checkout_session_id: session.id)

      redirect_to session.url, allow_other_host: true
    else
      redirect_to root_path, alert: t(".error")
    end
  end

  def cancel
    @booking.update(canceled: true)
    redirect_back fallback_location: root_path
  end

  def payment_canceled
    redirect_to root_path, alert: t(".cancel")
  end

  def payment_successful
    redirect_to root_path, notice: t(".success")
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def stripe_checkout_session(event, booking, customer)
    Stripe::Checkout::Session.create(
      customer:,
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "eur",
          unit_amount: booking.amount_cents,
          product_data: {
            name: event.title
          }
        },
        quantity: 1
      }],
      mode: "payment",
      success_url: successful_payment_url,
      cancel_url: canceled_payment_url
    )
  end

  def stripe_customer
    Stripe::Customer.create(
      name: current_user.full_name,
      email: current_user.email,
      description: "Customer id: #{current_user.id}"
    )
  end
end
