class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :haiku_id
      t.string :tag

      t.timestamps null: false
    end
  end
end
