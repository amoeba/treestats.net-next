/** chain.js
 *
 *  Fairly custom d3.hierarchy implementation of a cluster diagram.
 *
 *
 */


/**
 * attachMaximizeHandler
 *
 * Attaches an onclick handler to `selector` which toggles a CSS class
 * (.zoomed) on and off in order to provide fullscreen viewing of the chain.
 *
 * @param {string} selector - The CSS selector to use to find the
 * minimize/maximize button.
 */
const attachMaximizeHandler = function(selector) {
  const toggle_class = "toggle";
  const zoom_class = "zoomed";
  const toggles = document.querySelectorAll(selector);

  // Sanity check
  if (!toggles || !toggles.length || toggles.length !== 1) {
    return;
  }

  const toggle = toggles[0];

  toggle.onclick = function (e) {
    const currentClasses = toggle.parentElement.className;

    if (!(typeof currentClasses === "string")) {
      return;
    }

    if (!toggle.parentElement) {
      return;
    }

    if (currentClasses.indexOf(zoom_class) >= 0) {
      toggle.parentElement.className = toggle_class;
      toggle.innerHTML = "Maximize";

      // Trigger chart to resize
      window.dispatchEvent(new Event("resize"));
    } else {
      toggle.parentElement.className = toggle_class + " " + zoom_class;
      toggle.innerHTML = "Minimize";

      // Scroll to top
      if (window && window.scrollTo) {
        window.scrollTo(0, 0);
      }

      // Trigger chart to resize
      window.dispatchEvent(new Event("resize"));
    }
  };
}

/**
 * drawChain
 *
 * Draws an SVG in `selector` using `d3`.
 *
 * @param {string} selector - The CSS selector to use to find the element to
 * draw the chain on.
 */
const drawChain = function (selector) {
  const targets = document.querySelectorAll(selector);

  if (!targets || !targets.length || targets.length != 1) {
    return;
  }

  const target = targets[0];

  if (!target.dataset.server || !target.dataset.name) {
    return;
  }

  const server = target.dataset.server;
  const name = target.dataset.name;
  const width = 600;
  const height = 400;

  d3.json("/" + server + "/" + name + "/chain.json").then(data => {
    const tree_data = d3.stratify()
      .id(d => d.id)
      .parentId(d => d.patron_id)
      (data);

    const tree = tree_data => {
      const root = d3.hierarchy(tree_data);
      root.dx = 10;
      root.dy = width / (root.height + 1);
      return d3.tree().nodeSize([root.dx, 150])(root);
    }

    const root = tree(tree_data);
    const chart = d3.select(selector);

    // Remove "Loading..." text. A tad hacky?
    try {
      d3.select(selector)["_groups"][0][0].innerHTML = "";
    } catch (error) {
      // Nothing
    }

    d3.select(window)
      .on("resize", () => {
        chart.attr("width", chart.node().getBoundingClientRect().width);
        chart.attr("height", chart.node().getBoundingClientRect().height);

        svg.attr("viewBox", [0, 0, chart.node().getBoundingClientRect().width, chart.node().getBoundingClientRect().height])
      });

    const zoom = d3.zoom()
      .scaleExtent([0.1, 5])
      .on("zoom", () => {
        g.attr("transform", d3.event.transform);
      });

    const svg = chart.append("svg")
      .attr("viewBox", [0, 0, width, height])
      .call(zoom);

    const g = svg.append("g")
      .attr("font-size", 10);

    g.append("g")
      .attr("fill", "none")
      .attr("stroke", "#000")
      .selectAll("path")
      .data(root.links())
      .join("path")
      .attr("d", d3.linkHorizontal()
        .x(d => d.y)
        .y(d => d.x));

    const node = g.append("g")
      .selectAll("g")
      .data(root.descendants())
      .join("g")
      .attr("transform", d => `translate(${d.y},${d.x})`);

    node.append("svg:a")
      .attr("xlink:href", d => {
        return ["/", server, "/", d.data.data.name].join("");
      })
      .attr("aria-label", d => {
        return d.data.data.name;
      })
      .append("circle")
      .attr("fill", "#000")
      .attr("r", 2.5);

    node.append("svg:a")
      .attr("xlink:href", d => {
        return ["/", server, "/", d.data.data.name].join("");
      })
      .attr("aria-label", d => {
        return d.data.data.name;
      })
      .append("text")
      .attr("dy", "0.31em")
      .attr("x", d => d.children ? -6 : 6)
      .attr("text-anchor", d => d.children ? "end" : "start")
      .attr("style", d => d.data.data.name === name ? "font-weight: bold" : "font-weight: normal")
      .text(d => d.data.data.name)
      .clone(true).lower()
      .attr("stroke", "white");

    // Find and zoom to current character
    let zoomX = root.x;
    let zoomY = root.y;

    root.each(d => {
      if (d.data.data.name === name) {
        zoomX = d.x;
        zoomY = d.y;
      }
    });

    svg.transition().duration(250).call(
      zoom.transform,
      d3.zoomIdentity.translate(width / 2, height / 2).scale(1.25).translate(-zoomY, -zoomX)
    );
  }).catch(error => {
    try {
      d3.select(selector)["_groups"][0][0].innerHTML = "<div class=\"message\">" + error + "</div>";
    } catch (error) {
      // Nothing
    }
  });
};

(function () {
  attachMaximizeHandler(".toggle");
  drawChain("#chain");
})();
