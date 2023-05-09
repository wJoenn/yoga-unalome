class SessionsController < ApplicationController
  before_action :set_session, only: %i[update destroy]

  def create
    @session = Session.new(session_params)

    if @session.save
      redirect_to root_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def update
    if @session.update(session_params)
      redirect_to root_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def destroy
    @session.destroy
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:start_time, :duration, :address, :capacity)
  end

  def set_session
    @session = Session.find(params[:id])
  end
end
