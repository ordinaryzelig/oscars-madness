class HomeController < ApplicationController

  helper_method :entries, :categories

  def index
  end

  def about
  end

private

  def entries
    @entries ||= Entry.for_year(contest_year).all(:include => :picks).sort
  end

  def categories
    @categories ||= Category.for_year(contest_year).all(:include => {:nominees => :film})
  end

end
