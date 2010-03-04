require "digest/sha1"

class String
  
  def digest
    Digest::SHA1.hexdigest self
  end
  
end

class Player < ActiveRecord::Base
  
  has_many :picks
  attr_accessor :confirmation_password
  
  validates_presence_of :name
  validates_presence_of :password
  validates_confirmation_of :password
  validates_uniqueness_of :name
  
  before_create :hash_password
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
  
  def hash_password
    self.password = self.password.digest
  end
  
end
