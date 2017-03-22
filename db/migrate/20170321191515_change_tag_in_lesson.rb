class ChangeTagInLesson < ActiveRecord::Migration
  def change
    change_column :lessons, :tag, :integer
  end
end
