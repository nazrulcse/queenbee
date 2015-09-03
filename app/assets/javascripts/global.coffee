ready = ->
  $("[data-toggle='tooltip']").tooltip()

  $(document).on "click", ".is-openable", ->
    Turbolinks.visit($(this).data('url'))

  $('.tabs-section a').click (e) ->
    e.preventDefault()
    @tab('show')


$(document).ready(ready)
$(document).on('page:load', ready)
window.ready = ready
