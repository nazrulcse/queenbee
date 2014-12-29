ready = ->
  $("[data-toggle='tooltip']").tooltip()

  $(document).on "click", ".is-openable", ->
    Turbolinks.visit($(this).data('url'))


$(document).ready(ready)
$(document).on('page:load', ready)
window.ready = ready
