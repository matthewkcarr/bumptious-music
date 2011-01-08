class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :name, :default => ''
      t.integer :album_id, :default => 0
      t.integer :download_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
