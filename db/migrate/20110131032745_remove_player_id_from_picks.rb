class RemovePlayerIdFromPicks < ActiveRecord::Migration
  def self.up
    raise 'column not empty' if Pick.all.map(&:player_id).compact.any?
    remove_column :picks, :player_id
  end

  def self.down
    add_column :picks, :player_id, :integer
  end
end
