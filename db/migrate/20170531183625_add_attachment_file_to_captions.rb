class AddAttachmentFileToCaptions < ActiveRecord::Migration
  def self.up
    change_table :captions do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :captions, :file
  end
end
