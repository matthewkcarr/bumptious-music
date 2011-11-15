class AddAlbumSize < ActiveRecord::Migration
  def self.up
    add_column :albums, :mp3_size, :integer, :default => 0
    add_column :albums, :m4a_size, :integer, :default => 0
  end

  def self.down
    remove_column :albums, :m4a_size
    remove_column :albums, :mp3_size
  end
end
