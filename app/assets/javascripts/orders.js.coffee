$ ->
  previousTimeout = null

  $form = $('#global-search')
  $input = $form.find('input')

  data = ->
    out = {}
    out[$input.attr('name')] = $input.val().replace(/,/, '.')
    out
  search = -> $.get($form.attr('action'), data()).done searchDone
  searchDone = (response) ->
    console.log response
    content = $(response).find('#orders')
    $('#orders').replaceWith(content)

  $input.keyup ->
    if previousTimeout
      clearTimeout previousTimeout
    previousTimeout = setTimeout search, 100
