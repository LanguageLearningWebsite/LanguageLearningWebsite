class AttemptsController < ApplicationController
  helper 'quiz'

  before_action :authenticate_user!

  before_filter :load_quiz, only: [:new, :create]
  before_filter :load_attributes

  def index
    @quizzes = Quiz.active
  end

  def show
    @attempt = Attempt.find_by(id: params[:id])
    render :access_error if current_user.id != @attempt.participant_id

    render 'components/show'
  end

  def new
    @participant = current_user

    unless @quiz.nil?
      @attempt = @quiz.attempts.new
      @attempt.answers.build
    end

    render 'components/show'
  end

  def create
    @attempt = @quiz.attempts.new(params_whitelist)
    @attempt.participant = current_user
    if @attempt.valid? && @attempt.save
      correct_options_text = @quiz.correct_options.present? ? 'Bellow are the correct answers marked in green' : ''
      redirect_to course_lesson_component_attempt_path(params[:course_id], params[:lesson_id], params[:component_id], @attempt.id), notice: "Thank you for answering #{@quiz.component.name}! #{correct_options_text}"
    else
      build_flash(@attempt)
      @participant = current_user
      render :new
    end
  end

  def delete_user_attempts
    Attempt.where(participant_id: params[:user_id], quiz_id: params[:quiz_id]).destroy_all
    redirect_to new_attempt_path(quiz_id: params[:quiz_id])
  end

  private

  def load_quiz
    quiz_id =  Component.find(params[:component_id]).componentable.id
    @quiz = Quiz.find_by(id: quiz_id)
  end

  def load_attributes
    @component = Component.find(params[:component_id])
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
    end
  end

  def params_whitelist
    if params[:attempt]
      params[:attempt][:answers_attributes] = params[:attempt][:answers_attributes].map { |attrs| { question_id: attrs.first, option_id: attrs.last } }
      params.require(:attempt).permit!
    end
  end

  # def current_user
  #   view_context.current_user
  # end
end
