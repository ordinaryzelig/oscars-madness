class Player < ActiveRecord::Base
  
  has_many :picks
  
  before_create :generate_login
  after_create :generate_picks
  
  def points
    picks.map(&:points).sum
  end
  
  private
  
  def generate_picks
    Category.all.each { |cat| picks.create!(:category => cat) }
  end
  
  def generate_login
    self.login = email
  end
  
end
