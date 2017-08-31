class Attempt < ActiveRecord::Base

  self.table_name = "attempts"

  # acceptable_attributes :winner, :quiz, :quiz_id,
  #   :participant,
  #   :participant_id,
  #   :answers_attributes => ::Answer::AccessibleAttributes

  # relations
  belongs_to :quiz
  belongs_to :participant, polymorphic: true
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
    :reject_if => ->(q) { q[:question_id].blank? || q[:option_id].blank? }

  # validations
  validates :participant_id, :participant_type, :presence => true
  validate :check_number_of_attempts_by_quiz

  #scopes
  scope :wins,   -> { where(:winner => true) }
  scope :looses, -> { where(:winner => false) }
  scope :scores, -> { order("score DESC") }
  scope :for_quiz, ->(quiz) { where(:quiz_id => quiz.id) }
  scope :exclude_quiz,  ->(quiz) { where("NOT quiz_id = #{quiz.id}") }
  scope :for_participant, ->(participant) {
    where(:participant_id => participant.try(:id), :participant_type => participant.class.base_class)
  }

  # callbacks
  before_create :collect_scores

  def correct_answers
    return self.answers.where(:correct => true)
  end

  def incorrect_answers
    return self.answers.where(:correct => false)
  end

  def self.high_score
    return scores.first.score
  end

  private

  def check_number_of_attempts_by_quiz
    attempts = self.class.for_quiz(quiz).for_participant(participant)
    upper_bound = self.quiz.attempts_number

    if attempts.size >= upper_bound && upper_bound != 0
      errors.add(:quiz_id, "Number of attempts exceeded")
    end
  end

  def collect_scores
    self.score = self.answers.map(&:value).reduce(:+) || 0
  end
end
