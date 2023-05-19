class EventsController < ApplicationController
  before_action :redirect_unless_admin
  before_action :set_event, only: %i[update destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to root_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to root_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

  def redirect_unless_admin
    redirect_to root_path unless admin_user?
  end

  def event_params
    params.require(:event).permit(:start_time, :duration, :address, :capacity, :title, :price_cents)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
