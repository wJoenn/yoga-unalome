class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :confirmation
  before_action :redirect_unless_admin, only: %i[new edit create update destroy]
  before_action :set_event, only: %i[edit update destroy confirmation]

  def new
    @event = Event.new
  end

  def edit() end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to root_path, status: :ok
    else
      render "events/new", status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to root_path, status: :ok
    else
      render "events/edit", status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  def confirmation
    render partial: "shared/booking_confirmation", locals: { event: @event }, formats: %i[html]
  end

  private

  def redirect_unless_admin
    redirect_to root_path unless admin_user?
  end

  def event_params
    params.require(:event).permit(:start_time, :duration, :address, :capacity, :price_cents, :title)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
