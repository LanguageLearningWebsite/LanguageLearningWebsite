class Survey::Option < ActiveRecord::Base

  self.table_name = "survey_options"

  # acceptable_attributes :text, :correct, :weight

  #relations
  belongs_to :question

  # validations
  validates :text, :presence => true, :allow_blank => false

  # scopes
  scope :correct,   -> { where(:correct => true)  }
  scope :incorrect, -> { where(:correct => false) }

  # callbacks
  before_create :default_option_weight

  def to_s
    return self.text
  end

  def correct?
    return (self.correct == true)
  end

  private

  def default_option_weight
    self.weight = 1 if correct? && self.weight == 0
    self.correct = true if [Survey::QuestionsType.fill_in_blank].include?(self.question.questions_type_id)
  end

end
