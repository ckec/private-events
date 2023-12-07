class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def attend_event
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(attended_event: @event, attendee: current_user)

    if @attendance.save
      redirect_to event_path(@event), notice: "Successfully attended the event."
    else
      flash.now[:alert] = "Failed to attend the event."
      render "events/show"
    end
  end

  def leave_event
    @attendance = Attendance.find(params[:attendance_id])
    @attendance.destroy

    redirect_to event_path(@attendance.attended_event), notice: "Event attendance was successfully destroyed."
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end
end