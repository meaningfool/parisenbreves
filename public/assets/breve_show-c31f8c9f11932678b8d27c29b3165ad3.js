(function(){var e,t;$(document).ready(function(){return t()}),t=function(){var t,a;return""!==$("#breve_latitude").text()&&""!==$("#breve_longitude").text()?(t={zoom:14,center:new google.maps.LatLng($("#breve_latitude").text(),$("#breve_longitude").text()),mapTypeId:google.maps.MapTypeId.ROADMAP,disableDefaultUI:!0,draggable:!1,scrollwheel:!1,zoomControl:!0},window.map=new google.maps.Map(document.getElementById("map_canvas"),t),window.markersArray=[],a=new google.maps.LatLng($("#breve_latitude").text(),$("#breve_longitude").text()),e(a)):void 0},e=function(e){var t;return t=new google.maps.Marker({position:e,draggable:!1,map:map}),markersArray.push(t)}}).call(this);