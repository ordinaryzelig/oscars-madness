class Category < ActiveRecord::Base
  
  has_many :nominees
  
end
