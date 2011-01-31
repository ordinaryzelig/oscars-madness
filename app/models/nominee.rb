class Nominee < ActiveRecord::Base

  belongs_to :category
  belongs_to :film
  has_many :picks

  attr_accessor :film_name

  before_validation :find_film, :if => :film_name
  validates_presence_of :film_id

  default_scope :order => :created_at

  def declare_winner
    update_attributes! :is_winner => true
    picks.each do |pick|
      pick.update_attributes! :correct => true
    end
  end

  private

  def find_film
    self.film = Film.find_by_name!(self.film_name)
  end

end
