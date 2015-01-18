$ ->

  menu = $('#category-nav')
    .sidebar
      overlay: true
    # nothing in category nav should propogate to document.
    .on 'click', (event) ->
      event.stopPropagation()

  # Toggle menu.
  toggleButton = $('#categories-toggle').click (event) ->
    menu.sidebar('toggle')
    event.stopPropagation() # so doesn't interfere with document click.

  # Close sidebar on any click that does not originate from menu.
  $(document).on 'click', ->
    menu.sidebar('hide')

  # Close sidebar menu after link clicked.
  menu.find('a').click (event) ->
    menu.sidebar('toggle')
