class UserDashboardController < ApplicationController
  def show
    @bookings = current_user.bookings.includes(:event).select { |b| b.upcoming? && !b.canceled? && !b.refunded? }
  end
end
