class HomeController < ApplicationController

  helper_method :entries, :categories, :missing_picks

  def index
  end

  def about
  end

private

  def entries
    @entries ||=
      Entry
        .for_year(contest_year)
        .includes(:picks)
        .sort
  end

  def categories
    @categories ||=
      Category
        .for_year(contest_year)
        .includes(
          :nominees => [:film, :picks],
        )
  end

  def logged_in_player_entry
    @logged_in_player_entry ||=
      logged_in_player
        .entries
        .find_by_year(Contest.years.last)
  end

  def missing_picks
    @missing_picks ||= logged_in_player_entry.picks.missing
  end

end
