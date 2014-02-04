class Contest

  def self.years
    Category.unscoped.order(:year).pluck(:year).uniq
  end

  def self.this_year?
    years.last == Date.today.year
  end

end
