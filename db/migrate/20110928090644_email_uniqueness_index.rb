class EmailUniquenessIndex < ActiveRecord::Migration
  def self.up
	add_index :users, :email, :unique => true
  end

  def self.down
	remove_inedex :users, :email
  end
end
