class EventsController < ApplicationController
  before_action :authenticate, only: [:new, :create]

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: '作成しました'
    else
      render :new, status: 400
    end
  end

  def show
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to events_path, status: 400, notice: '存在しないイベントです'
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :content, :start_time, :end_time
    )
  end
end
