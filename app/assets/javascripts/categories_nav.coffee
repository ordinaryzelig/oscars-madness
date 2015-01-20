$ ->

  menu = $('#category-nav')
    .sidebar
      overlay: true
    # nothing in category nav should propogate to document.
    # E.g. clicking on empty space at bottom of category-nav should not close sidebar.
    .onClickOrTouch (event) ->
      event.stopPropagation()

  # Toggle menu.
  toggleButton = $('#categories-toggle').on 'click', (event) ->
    menu.sidebar 'toggle'
    event.stopPropagation()

  # Close sidebar on any click that does not originate from menu.
  $(document).onClickOrTouch ->
    menu.sidebar 'hide'

  # Close sidebar menu after link clicked.
  menu.find('a').on 'click', (event) ->
    menu.sidebar 'hide'
    event.stopPropagation()

$.fn.onClickOrTouch = (func) ->
  ele = $(@)
  for eventType in ['click', 'touchstart']
    ele.on eventType, func
  ele
