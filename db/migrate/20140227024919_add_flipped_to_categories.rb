class AddFlippedToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :flipped, :boolean
  end
end
