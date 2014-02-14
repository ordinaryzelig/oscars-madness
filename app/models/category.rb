class Category < ActiveRecord::Base

  has_many :nominees, -> { order(:created_at) }, inverse_of: :category
  has_many :picks,    -> { order(:created_at) }

  validates_presence_of :name
  validates_presence_of :points

  default_scope             { order(:created_at) }
  scope :for_year, ->(year) { where(:year => year) }
  scope :by_name,  ->       { order(:name) }

  def self.container
    all.map { |category| [category.name, category.id] }
  end

  def self.search(term)
    where('lower(name) like ?', "%#{term.downcase}%")
  end

  def has_winner?
    !winner.nil?
  end

  def winner
    @winner ||= nominees.detect(&:is_winner)
  end

end
