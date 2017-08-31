class Question < ActiveRecord::Base

  self.table_name = "questions"

  # acceptable_attributes :text, :quiz, :questions_type_id, :options_attributes => Option::AccessibleAttributes

  # relations
  belongs_to :quiz
  has_many   :options, dependent: :destroy
  accepts_nested_attributes_for :options,
    :reject_if => ->(a) { a[:text].blank? },
    :allow_destroy => true

  # validations
  validates :text, :presence => true, :allow_blank => false
  # validates :questions_type_id, :presence => true
  # validates_inclusion_of :questions_type_id, :in => QuestionsType.questions_type_ids, :unless => Proc.new{|q| q.questions_type_id.blank?}

  def correct_options
    return options.correct
  end

  def incorrect_options
    return options.incorrect
  end
end
