class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.text :blurb
      t.integer :year
      t.string :artist

      t.timestamps
    end
  end
end
