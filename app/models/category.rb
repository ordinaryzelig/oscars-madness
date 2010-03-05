class Category < ActiveRecord::Base
  
  has_many :nominees
  
  validates_presence_of :name
  validates_presence_of :points
  
  default_scope :order => :created_at
  
  extend ActiveSupport::Memoizable
  
  def self.container
    all.map { |category| [category.name, category.id] }
  end
  
  def has_winner?
    !winner.nil?
  end
  
  def winner
    nominees.detect(&:is_winner)
  end
  memoize :winner
  
end
