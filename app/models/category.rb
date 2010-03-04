class Category < ActiveRecord::Base
  
  has_many :nominees
  
  validates_presence_of :name
  validates_presence_of :points
  
  default_scope :order => :created_at
  
  def self.container
    all.map { |category| [category.name, category.id] }
  end
  
  def has_winner?
    nominees.detect(&:is_winner)
  end
  
end
