import * as d3 from "d3";

export default function (selector, server, character, options = {}) {
  d3.json("/" + server + "/" + character + "/chain").then(data => {
    const width = options.width || 600;
    const height = options.height || 400;

    const tree_data = d3.stratify()
      .id(function (d) { return d.id; })
      .parentId(function (d) { return d.patron_id; })
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
      .on("resize", function () {
        chart.attr("width", chart.node().getBoundingClientRect().width);
        chart.attr("height", chart.node().getBoundingClientRect().height);

        svg.attr("viewBox", [0, 0, chart.node().getBoundingClientRect().width, chart.node().getBoundingClientRect().height])
      });

    const zoom = d3.zoom()
      .scaleExtent([0.1, 5])
      .on("zoom", function () {
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
      .attr("xlink:href", function (d) {
        return ["/", server, "/", d.data.data.name].join("");
      })
      .attr("aria-label", function (d) {
        return d.data.data.name;
      })
      .append("circle")
      .attr("fill", "#000")
      .attr("r", 2.5);

    node.append("svg:a")
      .attr("xlink:href", function (d) {
        return ["/", server, "/", d.data.data.name].join("");
      })
      .attr("aria-label", function (d) {
        return d.data.data.name;
      })
      .append("text")
      .attr("dy", "0.31em")
      .attr("x", d => d.children ? -6 : 6)
      .attr("text-anchor", d => d.children ? "end" : "start")
      .attr("style", d => d.data.data.name === character ? "font-weight: bold" : "font-weight: normal")
      .text(d => d.data.data.name)
      .clone(true).lower()
      .attr("stroke", "white");

    // Find and zoom to current character
    let zoomX = root.x;
    let zoomY = root.y;

    root.each(d => {
      if (d.data.data.name === character) {
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
