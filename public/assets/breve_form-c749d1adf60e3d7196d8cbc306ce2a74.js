(function(){var e,t,n;$(document).ready(function(){var r;return t(),$("#breve_latitude").val()!==""&&$("#breve_longitude").val()!==""&&(r=new google.maps.LatLng($("#breve_latitude").val(),$("#breve_longitude").val()),window.map.setCenter(r),e(r)),$("#search_button").click(function(){var e;return e=$("#appendedInputButton").val(),n(e)})}),t=function(){var t;return t={zoom:14,center:new google.maps.LatLng(48.848933230926534,2.3467287359375177),mapTypeId:google.maps.MapTypeId.ROADMAP,disableDefaultUI:!0,scrollwheel:!1,zoomControl:!0},window.map=new google.maps.Map(document.getElementById("map_canvas"),t),window.markersArray=[],google.maps.event.addListener(map,"click",function(t){var n,r,i;if(markersArray)for(n in markersArray)markersArray[n].setMap(null);return e(t.latLng),i=t.latLng.lng(),r=t.latLng.lat(),$("#breve_latitude").val(r),$("#breve_longitude").val(i)})},e=function(e){var t;return t=new google.maps.Marker({position:e,draggable:!0,map:map}),google.maps.event.addListener(t,"dragend",function(){return $("#breve_latitude").val(t.position.lat()),$("#breve_longitude").val(t.position.lng())}),markersArray.push(t)},n=function(t){var n,r;if(markersArray)for(r in markersArray)markersArray[r].setMap(null);return n=new google.maps.Geocoder,n.geocode({address:t},function(t,n){return map.fitBounds(t[0].geometry.viewport),n===google.maps.GeocoderStatus.OK?($("#breve_latitude").val(t[0].geometry.location.lat()),$("#breve_longitude").val(t[0].geometry.location.lng()),map.setCenter(t[0].geometry.location),e(t[0].geometry.location)):alert("Geocode was not successful for the following reason: "+n)})}}).call(this);