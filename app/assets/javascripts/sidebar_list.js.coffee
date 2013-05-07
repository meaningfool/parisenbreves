$(document).ready ->
  initialize()


initialize = ->
	$(window).bind "load", ->
		$(".sb-image-wrapper").each ->
			wrapHeight = $(this).height()
			wrapWidth = $(this).width()
			img = $(this).find("img")
			imgHeight = img.height()
			imgWidth = img.width()
			marginTop = Math.round((wrapHeight - imgHeight) / 2)
			marginLeft = Math.round((wrapWidth - imgWidth) / 2)
			img.attr "style", "margin-top: " + marginTop + "px; margin-left: " + marginLeft + "px;"