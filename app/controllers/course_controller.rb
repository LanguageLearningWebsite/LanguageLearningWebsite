class CourseController < ApplicationController
  before_action :authenticate_user!, only: [:list]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @lessons = @course.lessons.order(:tag)

    @joined = false

    if !current_user.nil? && !current_user.courses.nil?
      @joined = current_user.courses.include?(@course)
    end

    @users = @course.users.order('created_at').first(10)
  end

  def list
    if !current_user.nil?
      @courses = current_user.courses
    end
  end
end
