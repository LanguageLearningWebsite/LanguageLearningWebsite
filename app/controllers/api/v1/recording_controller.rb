class Api::V1::RecordingController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def new
    recording = Recording.new(:url => params[:url], :user => current_user, :recording_list_id => params[:recording_list_id], :submitted => false)
    if recording.save
      flash[:notice] = "Recording uploaded!"
    else
      flash[:error] = recording.errors[:recordings].first
    end

    component = RecordingList.find(params[:recording_list_id]).component
    redirect_to course_lesson_component_path(component.lesson.course, component.lesson, component)
  end

  def submit
    recording = Recording.find(params[:id])
    component = recording.recording_list.component
    recording.update!(submitted: true)
    flash[:notice] = "Recording submitted for grading!"
    redirect_to course_lesson_component_path(component.lesson.course, component.lesson, component)
  end
end
