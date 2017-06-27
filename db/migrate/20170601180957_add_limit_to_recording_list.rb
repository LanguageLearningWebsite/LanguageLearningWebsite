class AddLimitToRecordingList < ActiveRecord::Migration
  def change
    add_column :recording_lists, :limit, :integer
  end
end
