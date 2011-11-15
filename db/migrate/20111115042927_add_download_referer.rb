class AddDownloadReferer < ActiveRecord::Migration
  def self.up
    add_column :tracks, :download_referer, :string, :default => "", :after => :download_count
  end

  def self.down
    remove_column :tracks, :download_referer
  end
end
