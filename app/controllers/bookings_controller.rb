class BookingsController < ApplicationController
  before_action :set_booking, only: %i[cancel]

  def create
    @event = Event.find(params[:event_id])
    @booking = @event.bookings.new
    @booking.user = current_user

    if @booking.save
      redirect_to root_path, notice: t(".success")
    else
      redirect_to root_path, alert: t(".error")
    end
  end

  def cancel
    @booking.update(canceled: true)
    redirect_back fallback_location: root_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
