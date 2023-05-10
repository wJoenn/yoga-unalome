class BookingsController < ApplicationController
  before_action :set_event
  before_action :set_booking, only: %i[update cancelation]

  def create
    @booking = @event.bookings.new(booking_params)

    if @booking.save
      redirect_to root_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to root_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def cancelation
    if @booking.canceled?
      @booking.update(status: "canceled")
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def booking_params
    params.require(:booking).permit(:canceled)
  end
end
