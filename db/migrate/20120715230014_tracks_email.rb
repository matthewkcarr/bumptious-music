class TracksEmail < ActiveRecord::Migration

  def self.up
    create_table :extracks_emails do |t|
      t.string  :email, :default => ''
      t.string  :link_hash, :default => 0
      t.string  :mp3_hash, :default => 0
      t.integer :visited_by, :default => 0
      t.string  :origin_ip, :default => 0
      t.timestamps
    end
  end

  def self.down
  end
end
