$(document).ready ->
  initialize()

$(window).resize ->
	initialize()

initialize = ->
	windowHeight = $(window).height()
	$("#home-wrapper").css 'min-height', windowHeight-40
	if ($(window).width() > 979)
		$(".photo-wrapper").css 'height', windowHeight-80
		$(".home-principles .span4").css 'height', 510
	else
		$(".photo-wrapper").css 'height', ''
		$(".home-principles .span4").css 'height', ''
	$(".photo-wrapper img").css 'max-height', windowHeight-90