class AddSlugToComponent < ActiveRecord::Migration
  def change
    add_column :components, :slug, :string
    add_index :components, :slug, unique: true
  end
end
