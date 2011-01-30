class AddYearToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :year, :integer
  end

  def self.down
    drop_column :categories, :year
  end
end
