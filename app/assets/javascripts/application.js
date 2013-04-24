// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-lightbox

$(document).ready(function(){
    $('.carousel').carousel({
    	interval: 8000
    });
    $('.dropdown-toggle').dropdown()
  });

$(document).ready(function(){
	
	$('#main').bind('ajax:complete',function(evt,xhr,status){
	  eval(xhr.responseText);
	});
});

$(document).ready(function(){
	if ($('#breve-textarea').length) {
		var text_length = $('#breve-textarea').val().length;
		$('#charNum').text(text_length);
		$('#breve-textarea').bind('keyup', function() {
			var len = $('#breve-textarea').val().length;
	        if (len > 400) {
	          $('#charNum').addClass("out-of-bound");
	        }
			$('#charNum').text(len);
		});
	}
});