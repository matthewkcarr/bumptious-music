class AddExtraDownloadVisits < ActiveRecord::Migration
  def self.up
    add_column :extracks_emails, :download_visits, :integer, :default => 0
  end

  def self.down
    remove_column :extracks_emails, :download_visits
  end
end
