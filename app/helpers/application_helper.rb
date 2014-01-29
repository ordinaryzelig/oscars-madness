module ApplicationHelper

  def exception_to_html(exception)
    html = h exception.message
    html += exception.backtrace.map { |bt| h(bt) }.join('<br />')
  end

  def show_category_nav
    @use_category_nav = true
  end

  def show_category_nav?
    @use_category_nav
  end

  def avatar(player)
    image_tag '/', class: 'ui image'
  end

  def progress_percentage(entry, categories)
    ((entry.points.to_f / possible_points(categories)) * 100).round
  end

  def possible_points(categories)
    categories.select(&:has_winner?).map(&:points).reduce(:+)
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
