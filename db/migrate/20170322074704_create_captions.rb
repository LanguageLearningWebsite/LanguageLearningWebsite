class CreateCaptions < ActiveRecord::Migration
  def change
    create_table :captions do |t|
      t.string :label
      t.string :language
      t.references :lesson, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
