var tabs=function(){'use strict';// Simple tabbing functionality
function a(a){for(var b=a.childNodes,e=0;e<b.length;e++)if(d(b[e],"tabbar"))for(var f=b[e].childNodes,g=0;g<f.length;g++)d(f[g],"tab")&&f[g].addEventListener("click",function(){c(this)},{passive:!0})}var b="inactive",c=function(a){if(a){var c=-1,e=-1,f=a.parentNode.parentNode.childNodes;for(var g in f)if(d(f[g],"tabbar")){var h=f[g].childNodes;// Tabs
for(var j in h)d(h[j],"tab")&&(c+=1,h[j]==a?(e=c,h[j].classList.remove(b),h[j].classList.add("active")):(h[j].classList.add(b),h[j].classList.remove("active")))}// Boxes
if(a.parentNode&&a.parentNode.parentNode){var k=a.parentNode.parentNode.childNodes;for(var g in c=-1,k)d(k[g],"box")&&(c+=1,c==e?(k[g].classList.remove(b),k[g].classList.add("active")):(k[g].classList.remove("active"),k[g].classList.add(b)))}}},d=function(a,b){return!!(a&&a.classList)&&a.classList.contains(b)};return a}();
//# sourceMappingURL=tabs.js.map
