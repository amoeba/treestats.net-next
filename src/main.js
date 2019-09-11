import chain from "./chain.js";
import tabify from "./tabs.js";

// Chain
const chainEl = document.getElementById("chain");

if (chainEl) {
  chain(chainEl, chainEl.dataset.server, chainEl.dataset.character);
}

// Tabs
const tabContainerEls = document.getElementsByClassName("tabcontainer");

tabContainerEls.forEach(container => {
  tabify(container);
});
