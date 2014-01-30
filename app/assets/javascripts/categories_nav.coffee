$ ->

  menu = $('#category-nav').sidebar
    overlay: true

  toggleButton = $('#categories-toggle').click ->
    menu.sidebar('toggle')

  # Close sidebar menu after clicked
  menu.find('a').click ->
    menu.sidebar('toggle')
