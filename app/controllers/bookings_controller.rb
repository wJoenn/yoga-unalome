class BookingsController < ApplicationController
  before_action :set_booking, only: %i[cancel]

  def create
    @event = Event.find(params[:event_id])
    @booking = @event.bookings.new
    @booking.user = current_user

    redirect_to root_path if @booking.save
  end

  def cancel
    @booking = Booking.find(params[:id])
    @booking.update(canceled: true)
    redirect_back fallback_location: root_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
