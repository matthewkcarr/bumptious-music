class CreateFanLocations < ActiveRecord::Migration
  def self.up
    create_table :fan_locations do |t|
      t.string :ip_address, :null => false, :default => ''
      t.string :city, :default => ''
      t.string :state, :default => ''
      t.string :country_code, :default => ''
      t.timestamps
    end
    add_index :fan_locations, [ :city, :state ]
    add_index :fan_locations, [ :state, :country_code ]
  end

  def self.down
    remove_index :fan_locations, :column => [ :city, :state ]
    drop_table :fan_locations
  end
end
