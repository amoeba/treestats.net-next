var tabs=function(){'use strict';// Simple tabbing functionality
// activate(ele)
//
// Called by tab's onclick handler, activates the tab and
// corresponding content box.
let a=function(a){if(!a)return;let c=-1,d=-1,e=a.parentNode.parentNode.childNodes;for(let f in e)if(b(e[f],"tabbar")){let g=e[f].childNodes;// Tabs
for(let e in g)b(g[e],"tab")&&(c+=1,g[e]==a?(d=c,g[e].className="tab active"):g[e].className="tab inactive")}// Boxes
if(a.parentNode&&a.parentNode.parentNode){const e=a.parentNode.parentNode.childNodes;for(let a in c=-1,e)b(e[a],"box")&&(c+=1,e[a].className=c==d?"box active":"box inactive")}},b=function(a,b){if(a)return-1<(" "+a.className+" ").indexOf(" "+b+" ")};// has_class(ele, class_name)
//
// Determines whether the given element ele has the class
// name class_name;
return function(c){const d=c.childNodes;for(let e=0;e<d.length;e++)if(b(d[e],"tabbar")){let c=d[e].childNodes;for(let d=0;d<c.length;d++)b(c[d],"tab")&&c[d].addEventListener("click",function(){a(this)})}}}();
//# sourceMappingURL=tabs.js.map
