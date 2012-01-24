class Category < ActiveRecord::Base

  has_many :nominees, :order => :created_at
  has_many :picks, :order => :created_at

  validates_presence_of :name
  validates_presence_of :points

  default_scope :order => :created_at
  named_scope :for_year, proc { |year| {:conditions => ["year = ?", year]} }
  named_scope :by_name, :order => :name

  extend ActiveSupport::Memoizable

  def self.container
    all.map { |category| [category.name, category.id] }
  end

  def has_winner?
    !winner.nil?
  end

  def winner
    nominees.detect(&:is_winner)
  end
  memoize :winner

end
