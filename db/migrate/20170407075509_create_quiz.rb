class CreateQuiz < ActiveRecord::Migration
  def self.up

    # quiz quizzes logic
    create_table :quiz_quizzes do |t|
      t.string  :name
      t.text    :description
      t.integer :attempts_number, :default => 0
      t.boolean :finished, :default => false
      t.boolean :active, :default => true

      t.timestamps
    end

    create_table :quiz_questions do |t|
      t.integer :quiz_id
      t.string  :text

      t.timestamps
    end

    create_table :quiz_options do |t|
      t.integer :question_id
      t.integer :weight, :default => 0
      t.string :text
      t.boolean :correct

      t.timestamps
    end

    # quiz answer logic
    create_table :quiz_attempts do |t|
      t.belongs_to :participant, :polymorphic => true
      t.integer    :quiz_id
      t.boolean    :winner
      t.integer    :score
    end

    create_table :quiz_answers do |t|
      t.integer    :attempt_id
      t.integer    :question_id
      t.integer    :option_id
      t.boolean    :correct
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_quizzes
    drop_table :quiz_questions
    drop_table :quiz_options

    drop_table :quiz_attempts
    drop_table :quiz_answers
  end
end
