# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$(document).ready ->
  initialize()

  if $("#breve_latitude").val() isnt "" and $("#breve_longitude").val() isnt ""
    p = new google.maps.LatLng($("#breve_latitude").val(), $("#breve_longitude").val())
    addMarker p

  $("#search_button").click ->
    loc = $("#search_address").val()
    jumpTo loc

initialize = ->
  mapOptions =
    zoom: 11
    center: new google.maps.LatLng 48.848933230926534, 2.3467287359375177
    mapTypeId: google.maps.MapTypeId.ROADMAP
  window.map = new google.maps.Map document.getElementById("map_canvas"), mapOptions 
  window.markersArray = []
  google.maps.event.addListener map, "click", (event) ->
    if markersArray
      for i of markersArray
        markersArray[i].setMap null
    addMarker event.latLng
    ln = event.latLng.lng()
    la = event.latLng.lat()
    $("#breve_latitude").val la
    $("#breve_longitude").val ln

addMarker = (location) ->
  marker = new google.maps.Marker(
    position: location
    draggable: true
    map: map
  )
  google.maps.event.addListener marker, "dragend", ->
    $("#breve_latitude").val marker.position.lat()
    $("#breve_longitude").val marker.position.lng()
  markersArray.push marker


jumpTo = (location) ->
  if markersArray
    for i of markersArray
      markersArray[i].setMap null
  geocoder = new google.maps.Geocoder()
  geocoder.geocode
    address: location, 
    (results, status) ->
	    map.fitBounds results[0].geometry.viewport
	    if status is google.maps.GeocoderStatus.OK
	      $("#breve_latitude").val results[0].geometry.location.lat()
	      $("#breve_longitude").val results[0].geometry.location.lng()
	      map.setCenter results[0].geometry.location
	      addMarker results[0].geometry.location
	    else
	      alert "Geocode was not successful for the following reason: " + status
