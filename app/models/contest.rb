class Contest

  def self.years
    Category.unscoped.order(:year).pluck(:year).uniq
  end

  def self.this_year?
    years.last == Date.today.year
  end

  def Contest.latest?(year)
    years.last == year
  end

end
