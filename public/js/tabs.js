// Simple tabbing functionality

const ACTIVE_CLASS = "active";
const INACTIVE_CLASS = "inactive";
const TABBAR_CLASS = "tabbar";
const BOX_CLASS = "box";
const TAB_CLASS = "tab";

// activate(ele)
//
// Called by tab's onclick handler, activates the tab and
// corresponding content box.
let activate = function (ele) {
  if (!ele) {
    return;
  }

  let index = -1,
    clicked_index = -1,
    children = ele.parentNode.parentNode.childNodes;

  for (let i in children) {
    if (!has_class(children[i], TABBAR_CLASS)) {
      continue;
    }

    let tabs = children[i].childNodes;

    // Tabs
    for (let tab in tabs) {
      if (!has_class(tabs[tab], TAB_CLASS)) {
        continue;
      }

      index += 1;

      if (tabs[tab] == ele) {
        clicked_index = index;
        tabs[tab].classList.remove(INACTIVE_CLASS);
        tabs[tab].classList.add(ACTIVE_CLASS);
      } else {
        tabs[tab].classList.add(INACTIVE_CLASS);
        tabs[tab].classList.remove(ACTIVE_CLASS);
      }
    }
  }

  // Boxes
  if (ele.parentNode && ele.parentNode.parentNode) {
    const children = ele.parentNode.parentNode.childNodes;

    index = -1;

    for (let i in children) {
      if (!has_class(children[i], BOX_CLASS)) {
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
}

// has_class(ele, class_name)
//
// Determines whether the given element ele has the class
// name class_name;
let has_class = function (ele, class_name) {
  if (ele && ele.classList) {
    return ele.classList.contains(class_name);
  } else {
    return false;
  }
}

function tabs(el) {
  const children = el.childNodes;

  for (let j = 0; j < children.length; j++) {
    if (!has_class(children[j], TABBAR_CLASS)) {
      continue;
    }

    let tabs = children[j].childNodes;

    for (let k = 0; k < tabs.length; k++) {
      if (!has_class(tabs[k], TAB_CLASS)) {
        continue;
      }

      tabs[k].addEventListener("click", function () {
        activate(this);
      }, {
        passive: true
      });
    }
  }
}
