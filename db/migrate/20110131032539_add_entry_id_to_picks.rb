class AddEntryIdToPicks < ActiveRecord::Migration
  def self.up
    add_column :picks, :entry_id, :integer
    change_column :picks, :player_id, :integer, :null => true
  end

  def self.down
    remove_column :picks, :entry_id
  end
end
