class Category < ActiveRecord::Base
  
  has_many :nominees
  
  validates_presence_of :name
  validates_presence_of :points
  
  def self.container
    all.map { |category| [category.name, category.id] }
  end
  
end
