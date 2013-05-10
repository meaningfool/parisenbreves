$(document).ready ->
  initialize()


initialize = ->
	loadHandler = $(".carousel").imagesLoaded()
	loadHandler.done ($images) ->
		i = 0
		wrapperWidth = $(".carousel").width()
		wrapperHeight = $(".carousel").height()-40
		while i < $(".carousel img").length
			current = $(".carousel img")[i]
			if (1.5*current.naturalWidth / current.naturalHeight) < (wrapperWidth / wrapperHeight)
				marginLeft = (wrapperWidth-1.5*current.naturalWidth*wrapperHeight / current.naturalHeight)/3
				marginTop = - 0.5 * wrapperHeight / 2 + 40
				$(".carousel img").eq(i).css 'margin-left', marginLeft
				$(".carousel img").eq(i).css 'margin-top', marginTop
				console.log 'cas 1  '  + marginLeft + '    imgWidth : ' + current.naturalWidth + '  imgHeight : ' + current.naturalHeight
			else if (current.naturalWidth / 1.5 /current.naturalHeight) > (wrapperWidth / wrapperHeight)
				marginTop = (wrapperHeight - wrapperWidth / (current.naturalWidth / 1.5 /current.naturalHeight))/2 + 40
				marginLeft = - 0.5 * wrapperWidth / 2
				$(".carousel img").eq(i).css 'margin-top', marginTop
				$(".carousel img").eq(i).css 'margin-left', marginLeft
				console.log 'cas 2  ' + marginTop + '    imgWidth : ' + current.naturalWidth + '  imgHeight : ' + current.naturalHeight
			else
				console.log 'cas 3    imgWidth : ' + current.naturalWidth + '  imgHeight : ' + current.naturalHeight
			i++