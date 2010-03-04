class Nominee < ActiveRecord::Base
  
  belongs_to :category
  belongs_to :film
  has_many :picks
  
  default_scope :order => :created_at
  
  def declare_winner
    update_attributes! :is_winner => true
    picks.each do |pick|
      pick.update_attributes! :correct => true
    end
  end
  
end
