class Contest

  def self.years
    Category.all(:order => :year).map(&:year).uniq
  end

  def self.this_year?
    years.last == Date.today.year
  end

end
