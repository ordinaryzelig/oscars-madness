class CreateNominees < ActiveRecord::Migration
  
  def self.up
    create_table :nominees do |t|
      t.string :name, {:null => false}
      t.belongs_to :film, {:null => false}
      t.belongs_to :category, {:null => false}
      t.boolean :is_winner
      t.timestamps
    end
  end
  
  def self.down
    drop_table :nominees
  end
  
end
