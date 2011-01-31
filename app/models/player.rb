require "digest/sha1"

class String

  def digest
    Digest::SHA1.hexdigest self
  end

end

class Player < ActiveRecord::Base

  has_many :entries

  validates_presence_of :name
  validates_presence_of :password
  validates_confirmation_of :password
  validates_uniqueness_of :name, :case_sensitive => false

  before_save :hash_password, :if => :password_changed?

  def self.authenticate(name, password)
    first :conditions => ["lower(name) = ? and password = ?", name.downcase, password.digest]
  rescue
    return nil
  end

  private

  def hash_password
    self.password = self.password.digest
  end

end
