(function(){var e;$(document).ready(function(){return e()}),e=function(){var e;return e=$(".carousel").imagesLoaded(),e.done(function(e){var t,n,r,i,s,o,u;n=0,o=$(".carousel").width(),s=$(".carousel").height()-40,u=[];while(n<$(".carousel img").length)t=$(".carousel img")[n],1.5*t.naturalWidth/t.naturalHeight<o/s?(r=(o-1.5*t.naturalWidth*s/t.naturalHeight)/3,i=-0.5*s/2+40,$(".carousel img").eq(n).css("margin-left",r),$(".carousel img").eq(n).css("margin-top",i),console.log("cas 1  "+r+"    imgWidth : "+t.naturalWidth+"  imgHeight : "+t.naturalHeight)):t.naturalWidth/1.5/t.naturalHeight>o/s?(i=(s-o/(t.naturalWidth/1.5/t.naturalHeight))/2+40,r=-0.5*o/2,$(".carousel img").eq(n).css("margin-top",i),$(".carousel img").eq(n).css("margin-left",r),console.log("cas 2  "+i+"    imgWidth : "+t.naturalWidth+"  imgHeight : "+t.naturalHeight)):console.log("cas 3    imgWidth : "+t.naturalWidth+"  imgHeight : "+t.naturalHeight),u.push(n++);return u})}}).call(this);