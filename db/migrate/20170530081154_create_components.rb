class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.references :lesson, index: true, foreign_key: true
      t.references :componentable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
