# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$(document).ready ->
  initialize()


initialize = ->
  if $("#breve_latitude").text() isnt "" and $("#breve_longitude").text() isnt ""
    mapOptions =
      zoom: 14
      center: new google.maps.LatLng $("#breve_latitude").text(), $("#breve_longitude").text()
      mapTypeId: google.maps.MapTypeId.ROADMAP
      disableDefaultUI: true
      draggable: false
      scrollwheel: false
      zoomControl: true
    window.map = new google.maps.Map document.getElementById("map_canvas"), mapOptions 
    window.markersArray = []
    p = new google.maps.LatLng($("#breve_latitude").text(), $("#breve_longitude").text())
    addMarker p

addMarker = (location) ->
  marker = new google.maps.Marker(
    position: location
    draggable: false
    map: map
  )
  markersArray.push marker

