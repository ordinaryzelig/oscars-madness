class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.belongs_to :player, {:null => false}
      t.integer :year, {:null => false}
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
