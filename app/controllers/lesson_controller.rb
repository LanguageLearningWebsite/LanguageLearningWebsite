class LessonController < ApplicationController
  before_action :authenticate_user!

  def show
    course = Course.find(params[:course_id])
    @lessons = course.lessons.order(:position)

    joined = false

    if !current_user.nil? && !current_user.courses.nil?
      joined = current_user.courses.include?(course)
    end

    if joined
      @lesson = @lessons.find(params[:id])
      @next_lesson = @lesson.next
      @prev_lesson = @lesson.previous
    else
      flash[:notice] = "You haven't enroll in the course!"
      redirect_to course
    end
  end

end
