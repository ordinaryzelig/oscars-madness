module StandingsHelper

  MAX_PROGRESS_PERCENTAGE = 95

  # Show progress points if any of following true:
  #   editing turned off
  #   showing previous year
  def show_progress_points?(contest_year)
    !picks_editable? || previous_contest_year?(contest_year)
  end

  def progress_percentage(entry, categories)
    possible_points = possible_points(categories)
    return 0 if possible_points == 0
    actual = ((entry.points.to_f / possible_points) * MAX_PROGRESS_PERCENTAGE).round
  end

  def standing_progress_color(entry, entries)
    case
    when top_scorer?(entry, entries)
      'successful'
    when bottom_scorer?(entry, entries)
      'failed'
    else
      ''
    end
  end

private

  def possible_points(categories)
    categories.select(&:has_winner?).map(&:points).reduce(0, :+)
  end

  def top_scorer?(entry, entries)
    scores(entries).max == entry.points
  end

  def bottom_scorer?(entry, entries)
    scores(entries).min == entry.points
  end

  def scores(entries)
    entries.map(&:points)
  end

end
