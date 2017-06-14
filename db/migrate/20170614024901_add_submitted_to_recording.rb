class AddSubmittedToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :submitted, :boolean
  end
end
