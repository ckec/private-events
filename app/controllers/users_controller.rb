class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @attendances = @user.attendances
    @events = @user.events
    @attended_events = Event.where(id: @attendances.pluck(:attended_event_id))
  end
end
