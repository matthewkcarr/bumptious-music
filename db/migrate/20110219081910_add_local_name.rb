class AddLocalName < ActiveRecord::Migration
  def self.up
    add_column :tracks, :local_name, :string
  end

  def self.down
    remove_column :tracks, :local_name
  end
end
