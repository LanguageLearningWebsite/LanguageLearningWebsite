class AttemptsController < ApplicationController
  helper 'quiz'

  before_action :authenticate_user!

  before_filter :load_quiz, only: [:new, :create]

  def index
    @quizzes = Quiz::Quiz.active
  end

  def show
    @attempt = Quiz::Attempt.find_by(id: params[:id])
    render :access_error if current_user.id != @attempt.participant_id
  end

  def new
    @participant = current_user

    unless @quiz.nil?
      @attempt = @quiz.attempts.new
      @attempt.answers.build
    end
  end

  def create
    @attempt = @quiz.attempts.new(params_whitelist)
    @attempt.participant = current_user
    if @attempt.valid? && @attempt.save
      correct_options_text = @quiz.correct_options.present? ? 'Bellow are the correct answers marked in green' : ''
      redirect_to attempt_path(@attempt.id), notice: "Thank you for answering #{@quiz.name}! #{correct_options_text}"
    else
      build_flash(@attempt)
      @participant = current_user
      render :new
    end
  end

  def delete_user_attempts
    Quiz::Attempt.where(participant_id: params[:user_id], quiz_id: params[:quiz_id]).destroy_all
    redirect_to new_attempt_path(quiz_id: params[:quiz_id])
  end

  private

  def load_quiz
    @quiz = Quiz::Quiz.find_by(id: params[:quiz_id])
  end

  def params_whitelist
    if params[:quiz_attempt]
      params[:quiz_attempt][:answers_attributes] = params[:quiz_attempt][:answers_attributes].map { |attrs| { question_id: attrs.first, option_id: attrs.last } }
      params.require(:quiz_attempt).permit!
    end
  end

  # def current_user
  #   view_context.current_user
  # end
end
