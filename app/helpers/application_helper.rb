module ApplicationHelper

  def latest_contest_year?(contest_year)
    contest_year == Contest.years.last
  end

  def previous_contest_year?(contest_year)
    !latest_contest_year?(contest_year)
  end

end
