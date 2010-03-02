class Film < ActiveRecord::Base
  
  has_many :nominations, :class_name => 'Nominee'
  
  def self.container
    all.map { |film| [film.name, film.id] }
  end
  
end
