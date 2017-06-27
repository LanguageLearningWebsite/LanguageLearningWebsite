class AddTypeToQuestion < ActiveRecord::Migration
  def change
    #Quiz Questions table
    add_column :questions, :questions_type_id, :integer

    #Quiz Answers table
    add_column :answers, :option_text, :text
  end
end
