class AddOmniauthToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :provider, :string
    add_column :players, :uid, :string
    change_column :players, :password, :string, :null => true
    remove_index :players, :name
  end

  def self.down
    remove_column :players, :provider
    remove_column :players, :uid
    change_column :players, :password, :string, :null => false
    add_index :players, :name, :unique => true
  end
end
