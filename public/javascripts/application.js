//autocomplete for film name.
$(function() {
  $('#nominee_film_name').autocomplete({
    source: '/films'
  })
})

//smooth scrolling.
$(function() {
  $('a').click(function(event) {
    var target = this.hash
    if(target) {
      event.preventDefault()
      if(target == '#top') { target = 0 }
      $.scrollTo(target, 1500, {over: -0.1})
    }
  })
})
