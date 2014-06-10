# a generic function that will prompt for and get the user's position

getLocation = () ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition((position)->
      sessionStorage.setItem('position', JSON.stringify(position))
    )

$('.events.index').ready ->
  getLocation()
