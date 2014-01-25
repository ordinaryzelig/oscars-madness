class Pick < ActiveRecord::Base

  belongs_to :category
  belongs_to :entry
  belongs_to :nominee, :class_name => "Nominee", :foreign_key => "nominee_id"

  scope :correct,      ->      { where(:correct => true) }
  scope :for_category, ->(cat) { where(:category_id => cat.id) }
  scope :picked,       ->      { where("nominee_id is not null") }

  def points
    correct ? category.points : 0
  end

end
