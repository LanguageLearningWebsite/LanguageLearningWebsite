class EnrollController < ApplicationController

  before_action :authenticate_user!

  def enroll
    course = Course.find(params[:course_id])
    current_user.enrollments.create(course: course)

    redirect_to course
  end
end
