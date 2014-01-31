require "digest/sha1"

class Player < ActiveRecord::Base

  has_many :entries

  validates_presence_of :name
  validates_presence_of :password, :unless => :uid
  validates_confirmation_of :password, :unless => :uid
  validates_uniqueness_of :name, :case_sensitive => false

  before_save :hash_password, :if => :password_changed?

  def self.authenticate(name, password)
    where("lower(name) = ? and password = ?", name.downcase, password.digest).first
  end

  def participated_in?(year)
    entries.for_year(year).present?
  end

  def participating_this_year?
    participated_in? Contest.years.last
  end

  def self.find_or_create_by_omniauth(omniauth)
    scope = where(
      provider: omniauth['provider'],
      uid:      omniauth['uid'],
    )
    player = scope.first || scope.new

    info = omniauth.fetch('info')

    if player.persisted?
      player.facebook_image_url ||= info.fetch('image')
      player.save! if player.changed?
      return player
    end

    player.name               = info.fetch('name')
    player.facebook_image_url = info.fetch('image')
    player.save!

    player
  end

  private

  def hash_password
    self.password = self.password.digest
  end

end
