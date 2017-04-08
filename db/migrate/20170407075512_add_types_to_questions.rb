class AddTypesToQuestions < ActiveRecord::Migration
  def change
    #Survey Questions table
    add_column :survey_questions, :questions_type_id, :integer

    #Survey Answers table
    add_column :survey_answers, :option_text, :text
  end
end
