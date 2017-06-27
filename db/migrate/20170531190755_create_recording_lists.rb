class CreateRecordingLists < ActiveRecord::Migration
  def change
    create_table :recording_lists do |t|

      t.timestamps null: false
    end
  end
end
