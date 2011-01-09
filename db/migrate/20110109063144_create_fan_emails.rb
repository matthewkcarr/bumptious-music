class CreateFanEmails < ActiveRecord::Migration
  def self.up
    create_table :fan_emails do |t|
      t.string :email, :default => ''
      t.timestamps
    end
  end

  def self.down
    drop_table :fan_emails
  end
end
