class BookingsController < ApplicationController
  before_action :set_event
  before_action :set_booking, only: %i[cancel_booking]

  def create
    @booking = @event.bookings.new(params[:booking])
    @booking.user = current_user

    if @booking.save
      render "pages/home", status: :unprocessable_entity
    end
  end

  def cancel_booking
    @booking.update(canceled: true)
    render "pages/home", status: :unprocessable_entity
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:session_id])
  end
end
