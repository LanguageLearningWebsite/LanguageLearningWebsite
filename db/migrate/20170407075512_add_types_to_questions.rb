class AddTypesToQuestions < ActiveRecord::Migration
  def change
    #Quiz Questions table
    add_column :quiz_questions, :questions_type_id, :integer

    #Quiz Answers table
    add_column :quiz_answers, :option_text, :text
  end
end
