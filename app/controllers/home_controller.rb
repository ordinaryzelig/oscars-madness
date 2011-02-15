class HomeController < ApplicationController

  before_filter :load_contest_year

  def index
    @entries = Entry.for_year(contest_year).all(:include => :picks).sort
    @categories = Category.for_year(contest_year).all(:include => {:nominees => :film})
  end

  def about

  end

end
