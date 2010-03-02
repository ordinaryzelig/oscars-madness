module ApplicationHelper
  
  def exception_to_html(exception)
    html = h exception.message
    html += exception.backtrace.map { |bt| h(bt) }.join('<br />')
  end
  
end
