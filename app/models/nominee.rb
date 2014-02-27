class Nominee < ActiveRecord::Base

  belongs_to :category
  belongs_to :film
  has_many :picks

  attr_accessor :film_name
  attr_accessor :category_name

  before_validation :find_film, :if => :film_name
  before_validation :find_category, :if => :category_name
  validates_presence_of :film_id

  default_scope { order(:created_at) }

  def declare_winner
    update_attributes! :is_winner => true
    picks.each do |pick|
      pick.update_attributes! :correct => true
    end
  end

  def major_name
    category.flipped ? name : film.name
  end

  def minor_name
    category.flipped ? film.name : name
  end

  private

  def find_film
    self.film = Film.find_by_name!(self.film_name)
  end

  # Assume latest year.
  def find_category
    self.category = Category.for_year(Contest.years.last).find_by_name!(self.category_name)
  end

end
