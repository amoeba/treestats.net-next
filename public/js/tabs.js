var tabs=function(){'use strict';// Simple tabbing functionality
const a="active",b="inactive",c="tabbar",d="tab";// activate(ele)
//
// Called by tab's onclick handler, activates the tab and
// corresponding content box.
let e=function(e){if(!e)return;let g=-1,h=-1,j=e.parentNode.parentNode.childNodes;for(let k in j){if(!f(j[k],c))continue;let i=j[k].childNodes;// Tabs
for(let c in i)f(i[c],d)&&(g+=1,i[c]==e?(h=g,i[c].classList.remove(b),i[c].classList.add(a)):(i[c].classList.add(b),i[c].classList.remove(a)))}// Boxes
if(e.parentNode&&e.parentNode.parentNode){const c=e.parentNode.parentNode.childNodes;for(let d in g=-1,c)f(c[d],"box")&&(g+=1,g==h?(c[d].classList.remove(b),c[d].classList.add(a)):(c[d].classList.remove(a),c[d].classList.add(b)))}},f=function(a,b){return!!(a&&a.classList)&&a.classList.contains(b)};// has_class(ele, class_name)
//
// Determines whether the given element ele has the class
// name class_name;
return function(a){const b=a.childNodes;for(let g=0;g<b.length;g++){if(!f(b[g],c))continue;let a=b[g].childNodes;for(let b=0;b<a.length;b++)f(a[b],d)&&a[b].addEventListener("click",function(){e(this)},{passive:!0})}}}();
//# sourceMappingURL=tabs.js.map
