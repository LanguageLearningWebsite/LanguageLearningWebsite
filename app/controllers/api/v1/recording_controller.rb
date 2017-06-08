class Api::V1::RecordingController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def new
    Recording.create!(:url => params[:url], :user => current_user, :recording_list_id => params[:recording_list_id])
    component = RecordingList.find(params[:recording_list_id]).component
    flash[:notice] = "Recording submitted!"
    redirect_to course_lesson_component_path(component.lesson.course, component.lesson, component)
  end
end
