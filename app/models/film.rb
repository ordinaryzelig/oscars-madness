class Film < ActiveRecord::Base
  
  has_many :nominations, :class_name => 'Nominee'
  
end
