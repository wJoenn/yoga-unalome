class BookingsController < ApplicationController
  before_action :set_booking, only: %i[cancel]

  def create
    event = Event.find(params[:event_id])
    booking = event.bookings.new(user: current_user)

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
    @booking.update(status: "canceled")
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
    description = "#{event.address}, #{event.start_time.strftime('%I:%M')} - #{event.end_time.strftime('%I:%M')}"
    Stripe::Checkout::Session.create(
      customer:,
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "eur",
          unit_amount: booking.amount_cents,
          product_data: {
            name: event.title,
            description:,
            images: ["https://i.imgur.com/NUuUUQF.png"]
          }
        },
        quantity: 1
      }],
      submit_type: "book",
      custom_text: {
        submit: {
          message: "Once the payment is approved you will receive a confirmation by mail or via facebook messenger"
        }
      },
      metadata: {
        recipient_id: User.find_by(admin: true)&.id
      },
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
