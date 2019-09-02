import chain from "./chain.js";

console.log("main.js");

const chainEl = document.getElementById("chain");

if (chainEl) {
  chain(chainEl, chainEl.dataset.server, chainEl.dataset.character);
}