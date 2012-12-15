class AddCreativeCommonsFlag < ActiveRecord::Migration
  def self.up
    add_column :albums, :cc_license, :boolean, :default => false
  end

  def self.down
    remove_column :albums, :cc_license
  end
end
