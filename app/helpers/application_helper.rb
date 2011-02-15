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

end
