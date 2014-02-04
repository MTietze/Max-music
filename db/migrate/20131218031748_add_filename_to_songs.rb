class AddFilenameToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :filename, :string
    rename_column :songs, :name, :title
  end
end
