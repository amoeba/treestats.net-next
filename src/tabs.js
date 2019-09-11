// Simple tabbing functionality

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
    if (has_class(children[i], "tabbar")) {
      let tabs = children[i].childNodes;

      // Tabs
      for (let j in tabs) {
        if (has_class(tabs[j], "tab")) {
          index += 1;

          if (tabs[j] == ele) {
            clicked_index = index;
            tabs[j].className = "tab active";
          } else {
            tabs[j].className = "tab inactive";
          }
        }
      }
    }
  }

  // Boxes
  if (ele.parentNode && ele.parentNode.parentNode) {
    const children = ele.parentNode.parentNode.childNodes;

    let box_index = -1;
    index = -1;

    for (let i in children) {
      if (has_class(children[i], "box")) {
        index += 1;

        if (index == clicked_index) {
          children[i].className = "box active";
        } else {
          children[i].className = "box inactive";
        }
      }
    }
  }
}

// has_class(ele, class_name)
//
// Determines whether the given element ele has the class
// name class_name;
let has_class = function (ele, class_name) {
  if (ele) {
    return (' ' + ele.className + ' ').indexOf(' ' + class_name + ' ') > -1
  }
}

export default function (el) {
  const children = el.childNodes;

  for (let j = 0; j < children.length; j++) {
    if (has_class(children[j], "tabbar")) {
      let tabs = children[j].childNodes;

      for (let k = 0; k < tabs.length; k++) {
        if (has_class(tabs[k], "tab")) {
          tabs[k].addEventListener("click", function () {
            activate(this);
          });
        }
      }
    }
  }
}