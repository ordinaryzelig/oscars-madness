require "digest/sha1"

class String

  def digest
    Digest::SHA1.hexdigest self
  end

end

class Player < ActiveRecord::Base

  include Enumerable

  has_many :picks

  validates_presence_of :name
  validates_presence_of :password
  validates_confirmation_of :password
  validates_uniqueness_of :name, :case_sensitive => false

  before_save :hash_password, :if => :password_changed?
  after_create :generate_picks

  def points
    picks.map(&:points).sum
  end

  def picks_attributes=(atts)
    atts.each do |pick_id, att|
      picks.detect { |pick| pick.id == pick_id.to_i }.update_attributes! :nominee_id => att[:nominee_id]
    end
  end

  def <=>(another_player)
    if another_player.points == points
      if another_player.picks.correct.size == picks.correct.size
        name.downcase <=> another_player.name.downcase
      else
        another_player.picks.correct.size <=> picks.correct.size
      end
    else
      another_player.points <=> points
    end
  end

  def self.authenticate(name, password)
    first :conditions => ["lower(name) = ? and password = ?", name.downcase, password.digest]
  rescue
    return nil
  end

  private

  def generate_picks
    Category.all.each { |cat| picks.create!(:category => cat) }
  end

  def hash_password
    self.password = self.password.digest
  end

end
