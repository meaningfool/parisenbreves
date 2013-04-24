$(document).ready ->
	$(".search-form").find("select").bind "change", ->
  		$(this).closest("form").trigger "submit"