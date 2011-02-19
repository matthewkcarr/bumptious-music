class AddAlbumNumber < ActiveRecord::Migration
  def self.up
    add_column :albums, :album_number, :integer
  end

  def self.down
    remove_column :albums, :album_number
  end
end
