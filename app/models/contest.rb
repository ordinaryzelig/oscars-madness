class Contest

  def self.years
    Category.all(:order => :year).map(&:year).uniq
  end

end
