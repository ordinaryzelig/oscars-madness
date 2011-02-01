require "digest/sha1"

class String

  def digest
    Digest::SHA1.hexdigest self
  end

end

class Player < ActiveRecord::Base

  has_many :entries

  validates_presence_of :name
  validates_presence_of :password, :unless => :uid
  validates_confirmation_of :password, :unless => :uid
  validates_uniqueness_of :name, :case_sensitive => false

  before_save :hash_password, :if => :password_changed?

  def self.authenticate(name, password)
    first :conditions => ["lower(name) = ? and password = ?", name.downcase, password.digest]
  rescue
    return nil
  end

  def participated_in?(year)
    entries.for_year(year).present?
  end

  def participating_this_year?
    participated_in? Date.today.year
  end

  def self.find_or_create_by_omniauth(omniauth)
    player = Player.find_or_initialize_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    return player if player.id
    player.name = omniauth['user_info']['name']
    player.save!
    player
  end

  private

  def hash_password
    self.password = self.password.digest
  end

end
