class CreateQuizzes < ActiveRecord::Migration
  def self.up

    # assignment quizzes logic
    create_table :quizzes do |t|
      t.text    :description
      t.integer :attempts_number, :default => 0
      t.boolean :finished, :default => false
      t.boolean :active, :default => true

      t.timestamps
    end

    create_table :questions do |t|
      t.integer :quiz_id
      t.text  :text

      t.timestamps
    end

    create_table :options do |t|
      t.integer :question_id
      t.integer :weight, :default => 0
      t.string :text
      t.boolean :correct

      t.timestamps
    end

    # quiz answer logic
    create_table :attempts do |t|
      t.belongs_to :participant, :polymorphic => true
      t.integer    :quiz_id
      t.boolean    :winner
      t.integer    :score
    end

    create_table :answers do |t|
      t.integer    :attempt_id
      t.integer    :question_id
      t.integer    :option_id
      t.boolean    :correct
      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
    drop_table :questions
    drop_table :options

    drop_table :attempts
    drop_table :answers
  end
end
