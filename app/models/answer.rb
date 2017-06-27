class Answer < ActiveRecord::Base

  self.table_name = "answers"

  # acceptable_attributes :attempt, :option, :correct, :option_id, :question, :question_id, :option_text

  # associations
  belongs_to :attempt
  belongs_to :option
  belongs_to :question

  # validations
  validates :option_id, :question_id, :presence => true
  validates :option_id, :uniqueness => { :scope => [:attempt_id, :question_id] }
  validates :option_text, :presence => true , :if => Proc.new{|a| a.option && ( a.question && [QuestionsType.fill_in_blank].include?(a.question.questions_type_id)) }

  # callbacks
  after_create :characterize_answer

  def value
    points = (self.option.nil? ? Option.find(option_id) : self.option).weight
    correct?? points : - points
  end

  def correct?
    if [QuestionsType.fill_in_blank].include?(self.question.questions_type_id)
      self.correct ||= (self.option.text == self.option_text)
    elsif [QuestionsType.multiple_choice].include?(self.question.questions_type_id)
      self.correct ||= self.option.correct?
    end
  end

  private

  def characterize_answer
    update_attribute(:correct, self.correct?)
  end

end
