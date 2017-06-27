class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :url
      t.references :user, index: true, foreign_key: true
      t.references :recording_list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
