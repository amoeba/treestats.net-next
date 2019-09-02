import chain from "./chain.js";

// Chain
const chainEl = document.getElementById("chain");

if (chainEl) {
  chain(chainEl, chainEl.dataset.server, chainEl.dataset.character);
}