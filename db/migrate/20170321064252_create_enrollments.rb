class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :course, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :enrollments, [:course_id, :user_id], unique: true
  end
end
