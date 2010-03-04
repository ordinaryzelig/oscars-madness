class Film < ActiveRecord::Base
  
  has_many :nominations, :class_name => 'Nominee'
  
  default_scope :order => :name
  
  def self.container
    all.map { |film| [film.name, film.id] }
  end
  
end
