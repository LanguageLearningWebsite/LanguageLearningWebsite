class RemoveLanguageFromCaption < ActiveRecord::Migration
  def change
    remove_column :captions, :language, :string
  end
end
