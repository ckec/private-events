class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_event, only: [:show, :destroy]
  before_action :authorize_user, only: [:destroy]

  def index
    @events = Event.all
    @past_events = Event.past
    @future_events = Event.future
  end

  def new
    @event = current_user.events.build
  end

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: 'Event not found.'
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end
  
  def show
    @event = Event.find(params[:id])
    @attendance = Attendance.new 
    @past_events = Event.past
    @future_events = Event.future
  end

  
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :location, :user_id)
  end

  def authorize_user
    redirect_to events_path, alert: "You don't have permission to perform this action." unless current_user == @event.creator
  end
end