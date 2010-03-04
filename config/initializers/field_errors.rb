ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "<span class=\"fieldWithErrors\">" + html_tag + "</span>"
end
