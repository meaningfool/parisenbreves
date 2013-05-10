/*!
 * jQuery imagesLoaded plugin v2.1.1
 * http://github.com/desandro/imagesloaded
 *
 * MIT License. by Paul Irish et al.
 */
/*jshint curly: true, eqeqeq: true, noempty: true, strict: true, undef: true, browser: true */
/*global jQuery: false */
(function(e,t){"use strict";var n="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";e.fn.imagesLoaded=function(r){function c(){var t=e(f),n=e(l);s&&(l.length?s.reject(u,t,n):s.resolve(u)),e.isFunction(r)&&r.call(i,u,t,n)}function h(e){p(e.target,e.type==="error")}function p(t,r){if(t.src===n||e.inArray(t,a)!==-1)return;a.push(t),r?l.push(t):f.push(t),e.data(t,"imagesLoaded",{isBroken:r,src:t.src}),o&&s.notifyWith(e(t),[r,u,e(f),e(l)]),u.length===a.length&&(setTimeout(c),u.unbind(".imagesLoaded",h))}var i=this,s=e.isFunction(e.Deferred)?e.Deferred():0,o=e.isFunction(s.notify),u=i.find("img").add(i.filter("img")),a=[],f=[],l=[];return e.isPlainObject(r)&&e.each(r,function(e,t){e==="callback"?r=t:s&&s[e](t)}),u.length?u.bind("load.imagesLoaded error.imagesLoaded",h).each(function(r,i){var s=i.src,o=e.data(i,"imagesLoaded");if(o&&o.src===s){p(i,o.isBroken);return}if(i.complete&&i.naturalWidth!==t){p(i,i.naturalWidth===0||i.naturalHeight===0);return}if(i.readyState||i.complete)i.src=n,i.src=s}):c(),s?s.promise(i):i}})(jQuery);