class CreatePicks < ActiveRecord::Migration
  
  def self.up
    create_table :picks do |t|
      t.belongs_to :category, {:null => false}
      t.belongs_to :nominee
      t.belongs_to :player, {:null => false}
      t.boolean :correct
      t.timestamps
    end
  end
  
  def self.down
    drop_table :picks
  end
end
