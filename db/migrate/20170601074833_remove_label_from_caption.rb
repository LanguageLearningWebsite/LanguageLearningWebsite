class RemoveLabelFromCaption < ActiveRecord::Migration
  def change
    remove_column :captions, :label, :string
  end
end
