class CreateAdminConfigs < ActiveRecord::Migration
  
  def self.up
    create_table :admin_configs do |t|
      t.string :admin_password
      t.boolean :picks_editable
      t.timestamps
    end
  end
  
  def self.down
    drop_table :admin_configs
  end
  
end
