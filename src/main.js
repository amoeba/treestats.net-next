import chain from "./chain.js";
import { select_by_class, has_class, activate } from "./tabs.js";

// Chain
const chainEl = document.getElementById("chain");

if (chainEl) {
  chain(chainEl, chainEl.dataset.server, chainEl.dataset.character);
}

// Tabs
var tabcontainers = select_by_class("tabcontainer");

for(var i = 0; i < tabcontainers.length; i++) {
  var children = tabcontainers[i].childNodes;

  for(var j = 0; j < children.length; j++) {
    if(has_class(children[j], "tabbar")) {
      var tabs = children[j].childNodes;

      for(var k = 0; k < tabs.length; k++) {
        if(has_class(tabs[k], "tab")) {
          tabs[k].addEventListener("click", function() {
            activate(this);
          });

        }
      }
    }
  }
}