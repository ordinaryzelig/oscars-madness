class Pick < ActiveRecord::Base

  belongs_to :category
  belongs_to :entry
  belongs_to :nominee, :class_name => "Nominee", :foreign_key => "nominee_id"

  named_scope :correct, :conditions => {:correct => true}
  named_scope :for_category, proc { |cat| {:conditions => {:category_id => cat.id}} }
  named_scope :picked, :conditions => "nominee_id is not null"

  def points
    correct ? category.points : 0
  end

end
