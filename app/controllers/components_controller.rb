class ComponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_s3_base_url

  def show
    @component = Component.find(params[:id])

    @course = Course.find(params[:course_id])
    @lessons = @course.lessons.order(:position)

    joined = false

    if !current_user.nil? && !current_user.courses.nil?
      joined = current_user.courses.include?(@course)
    end

    if joined
      @lesson = @lessons.find(params[:lesson_id])
      @components = @lesson.components.order(:position)
      @next_lesson = @lesson.next
      @prev_lesson = @lesson.previous
    else
      flash[:error] = "You haven't enroll in the course!"
      redirect_to @course
    end
  end

  private
  def set_s3_base_url
    @s3_base_url = "recordings/#{SecureRandom.uuid}/"
  end
end
