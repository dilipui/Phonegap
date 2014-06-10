$ ->
  # auto close flash message after some time
  setTimeout (->
    $("#flash-alert").fadeOut "slow", ->
      $(this).remove()
      return
    return
  ), 2000

  # remove flash message clicking on close 
  $('#flash-alert').click ->
    $(this).fadeOut 300, ->
      $(this).remove()
      return