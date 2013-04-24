
$(document).ready ->
  initialize()


initialize = ->
  mapOptions =
    zoom: 14
    center: new google.maps.LatLng '48.855', '2.333'
    mapTypeId: google.maps.MapTypeId.ROADMAP
    disableDefaultUI: true
    draggable: true
    scrollwheel: false
    zoomControl: true
  map = new google.maps.Map document.getElementById("map_page"), mapOptions 
  infowindow = new google.maps.InfoWindow(
    maxWidth: 400
    )
  markers = []
  pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
    new google.maps.Size(40, 37),
    new google.maps.Point(0, 0),
    new google.maps.Point(12, 35));
  for breve in gon.published
    marker = new google.maps.Marker
      position: new google.maps.LatLng breve.latitude, breve.longitude
      draggable: false
      map: map
      icon: "https://maps.gstatic.com/mapfiles/ms2/micons/red-dot.png"
      shadow: pinShadow
    makePublishedWindowEvent map, infowindow, breve, marker
    markers.push marker
  for breve in gon.draft
    marker = new google.maps.Marker
      position: new google.maps.LatLng breve.latitude, breve.longitude
      draggable: false
      map: map
      icon: "https://maps.gstatic.com/mapfiles/ms2/micons/blue-dot.png"
      shadow: pinShadow
    makeDraftWindowEvent map, infowindow, breve, marker
    markers.push marker


makePublishedWindowEvent = (map, infowindow, breve, marker) ->
  google.maps.event.addListener marker, "click", ->
    content = "<div class='published_window'><img src='" + breve.photo_file_name + "'></img><a href='" + gon.root + "breves/" + breve.id + "'><h4>" + breve.title + "</h4></a></div>"
    infowindow.setContent content
    infowindow.open map, marker

makeDraftWindowEvent = (map, infowindow, breve, marker) ->
  google.maps.event.addListener marker, "click", ->
    content = "<div class='draft_window'><a href='" + gon.root + "breves/" + breve.id + "'><h4>" + breve.title + "</h4></a></div>"
    infowindow.setContent content
    infowindow.open map, marker