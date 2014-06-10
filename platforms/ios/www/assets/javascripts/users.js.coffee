
$('#map-canvas').ready ->
  if($('#map-canvas').length > 0)
    map = null
    markersArray = []

    position = JSON.parse(sessionStorage.getItem('position'))
    lat = position.coords.latitude
    lng = position.coords.longitude
    latlng = new google.maps.LatLng(lat, lng)

    settings = {
        zoom: 17,
        center: latlng,
        mapTypeControl: true,
        scaleControl: true,
        mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
        },
        navigationControl: true,
        navigationControlOptions: {
            style: google.maps.NavigationControlStyle.DEFAULT
        },
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        backgroundColor: 'white'
    }

    map = new google.maps.Map(document.getElementById('map-canvas'), settings)

    marker = new google.maps.Marker({
      position: latlng,
      map: map,
      title: 'You are here!'
    })


$('#map-canvas-activity').ready ->
  if($('#map-canvas-activity').length > 0)
    map = null
    markersArray = []

    latlng = new google.maps.LatLng(39.9538888, -75.19747)
    settings = {
        zoom: 17,
        center: latlng,
        mapTypeControl: true,
        scaleControl: true,
        mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
        },
        navigationControl: true,
        navigationControlOptions: {
            style: google.maps.NavigationControlStyle.DEFAULT
        },
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        backgroundColor: 'white'
    }

    map = new google.maps.Map(document.getElementById('map-canvas-activity'), settings)

    marker = new google.maps.Marker({
      position: latlng,
      map: map,
      title: ''
    })

