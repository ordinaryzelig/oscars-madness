class Player < ActiveRecord::Base
  
  has_many :picks
  
  before_create :generate_login
  after_create :generate_picks
  
  def points
    picks.map(&:points).sum
  end
  
  def picks_attributes=(atts)
    atts.each do |pick_id, att|
      picks.detect { |pick| pick.id == pick_id.to_i }.update_attributes! :nominee_id => att[:nominee_id]
    end
  end
  
  private
  
  def generate_picks
    Category.all.each { |cat| picks.create!(:category => cat) }
  end
  
  def generate_login
    self.login = email
  end
  
end
