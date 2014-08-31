ready = ->
  $("#toggle-push-menu").click (e) ->
    e.preventDefault()
    $(".push-menu").toggleClass "active"
    $(".push-menu").toggleClass "push-menu-open"

  $("[data-toggle='tooltip']").tooltip()

  $(document).on "click", ".is-openable", ->
    Turbolinks.visit($(this).data('url'))


$(document).ready(ready)
$(document).on('page:load', ready)
window.ready = ready
