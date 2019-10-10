/**
 * tabs.js
 *
 * Fairly custom tabbing functionality. Uses click handlers and CSS classes
 * defined elsewhere to toggle visibility on elements on the page to simulate
 * a tab-like functionality.
 */

// Globals
const ACTIVE_CLASS = "active";
const INACTIVE_CLASS = "inactive";
const TABBAR_CLASS = "tabbar";
const BOX_CLASS = "box";
const TAB_CLASS = "tab";

/**
 * activate
 *
 * Called by tab's onclick handler, activates the tab and
 * corresponding content box.
 *
 * @param (*) ele - The element to activate tabs on
 */
const activate = function (el) {
  if (!el) {
    return;
  }

  let index = -1,
    clicked_index = -1,
    children = el.parentNode.parentNode.childNodes;

  for (let i in children) {
    if (!hasClass(children[i], TABBAR_CLASS)) {
      continue;
    }

    let tabs = children[i].childNodes;

    // Hide or show tabs
    for (let tab in tabs) {
      if (!hasClass(tabs[tab], TAB_CLASS)) {
        continue;
      }

      index += 1;

      if (tabs[tab] == el) {
        clicked_index = index;
        tabs[tab].classList.remove(INACTIVE_CLASS);
        tabs[tab].classList.add(ACTIVE_CLASS);
      } else {
        tabs[tab].classList.add(INACTIVE_CLASS);
        tabs[tab].classList.remove(ACTIVE_CLASS);
      }
    }
  }

  // Hide or show boxes
  if (el.parentNode && el.parentNode.parentNode) {
    const children = el.parentNode.parentNode.childNodes;

    index = -1;

    for (let i in children) {
      if (!hasClass(children[i], BOX_CLASS)) {
        continue;
      }

      index += 1;

      if (index == clicked_index) {
        children[i].classList.remove(INACTIVE_CLASS);
        children[i].classList.add(ACTIVE_CLASS);
      } else {
        children[i].classList.remove(ACTIVE_CLASS);
        children[i].classList.add(INACTIVE_CLASS);
      }
    }
  }
};

/**
 * hasClass
 *
 * Determines whether the given element ele has the class `name`.
 */
const hasClass = function (el, name) {
  if (el && el.classList) {
    return el.classList.contains(name);
  } else {
    return false;
  }
}

/**
 * enableTabs
 *
 * Sets onclick handlers appropriate on the target element.
 *
 * @param {*} el - The element to enable tabs on
 */
const enableTabs = function (el) {
  const children = el.childNodes;

  for (let j = 0; j < children.length; j++) {
    if (!hasClass(children[j], TABBAR_CLASS)) {
      continue;
    }

    let tabs = children[j].childNodes;

    for (let k = 0; k < tabs.length; k++) {
      if (!hasClass(tabs[k], TAB_CLASS)) {
        continue;
      }

      tabs[k].addEventListener("click", function () {
        activate(this);
      }, {
        passive: true
      });
    }
  }
};

/**
 * tabs
 *
 * @param {*} selector - CSS selector to use to set up tabs on elements on the
 * page.
 */
const tabs = function (selector) {
  document.querySelectorAll(selector)
    .forEach(function(el) {
      enableTabs(el);
    });
};

(function () {
  tabs(".tabcontainer");
})();
