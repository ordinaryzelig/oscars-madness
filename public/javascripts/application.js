$(function() {

  // autocomplete for film name.
  $('#nominee_film_name').autocomplete({
    source: '/films'
  })

  // autocomplete for category name.
  $('#nominee_category_name').autocomplete({
    source: '/categories'
  })

  // smooth scrolling.
  $('a').click(function(event) {
    var target = this.hash
    if(target) {
      event.preventDefault()
      if(target == '#top') { target = 0 }
      $.scrollTo(target, 1500, {over: -0.1})
    }
  })

  // Focus on input when page loads.
  $('.focus_on_load').focus()

  // Toggle categories drawer.
  $('#category_nav').click(function() {
    $(this).toggleClass('expanded')
  })

})
