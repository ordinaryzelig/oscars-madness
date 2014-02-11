module ApplicationHelper

  def latest_contest_year?(contest_year)
    contest_year == Contest.years.last
  end

  def previous_contest_year?(contest_year)
    !latest_contest_year?(contest_year)
  end

  def contest_year_select
    year_paths = Contest.years.map { |year| [year, root_path(:contest_year => year)] }
    selected_year_path = root_path(:contest_year => contest_year)
    select_options = options_for_select(year_paths, selected_year_path)

    options = {
      onchange: 'window.location = this.value',
    }

    select_tag :contest_year, select_options, options
  end

  def logged_in_player?(player)
    player == logged_in_player
  end

end
