/**
 * popchart.js
 *
 * Minimal multi-line chart to plot server population counts over time.
 */

// Globals
const url = "/populations.json";
const width = 600;
const height = 300
const margin = ({ top: 20, right: 80, bottom: 20, left: 40 })

// Server ID -> Name mapping
const serverNames = new Map();
serverNames.set(0, "Darktide")
serverNames.set(1, "Frostfell")
serverNames.set(2, "Harvestgain")
serverNames.set(3, "Leafcull")
serverNames.set(4, "Morningthaw")
serverNames.set(5, "Thistledown")
serverNames.set(6, "Solclaim")
serverNames.set(7, "Verdantine")
serverNames.set(8, "WintersEbb")

// Date formatting utility function
const formatDate = d3.timeParse("%Y-%m-%d")

// Custom color scheme
const colorScheme = [
  "red", // Darktide
  "lightblue", // Frostfell
  "gold", // Harvestgain
  "green", // Leafcull
  "orange", // Morningthaw
  "lightgreen", // Thistledown
  "purple", // Solclaim
  "pink", // Verdantine
  "slateblue",
];

/**
 * popchart
 *
 * @param {*} selector - CSS selector to use to find the element to draw the
 * chart into.
 */
const popchart = function (selector) {
  d3.json(url).then(json => {
    // Tidy up data
    let data = json.map(d => {
      return {
        "server": d.id,
        "date": formatDate(d.date),
        "count": d.count
      }
    });

    // Re-format data group-wise
    const grouped = d3.group(data, d => d.server);

    // Scales
    const x = d3.scaleUtc()
      .domain(d3.extent(data, d => d.date))
      .range([margin.left, width - margin.right])

    const y = d3.scaleLinear()
      .domain([0, d3.max(data, d => d.count)]).nice()
      .range([height - margin.bottom, margin.top])

    const color = d3.scaleOrdinal()
      .domain(Array.from(grouped.keys()))
      .range(colorScheme);

    // Axes
    const xAxis = g => g
      .attr("transform", `translate(0,${height - margin.bottom})`)
      .call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))

    const yAxis = g => g
      .attr("transform", `translate(${margin.left},0)`)
      .call(d3.axisLeft(y))
      .call(g => g.select(".tick:last-of-type text").clone()
        .attr("x", 3)
        .attr("text-anchor", "start")
        .attr("font-weight", "bold")
        .text("Players"))

    // Chart
    const chart = d3.select(selector)
    const svg = chart
      .append("svg")
      .attr("viewBox", [0, 0, width, height]);

    svg.append("g")
      .call(xAxis);

    svg.append("g")
      .call(yAxis);

    // Lines
    const line = d3.line()
      .x(d => x(d.date))
      .y(d => y(d.count))

    const servers = color.domain().map((key) => {
      return {
        name: key,
        values: grouped.get(key)
      };
    });

    const server = svg.selectAll(".server")
      .data(servers)
      .enter().append("g")
      .attr("class", "server");

    server.append("path")
      .attr("class", "line")
      .attr("fill", "none")
      .attr("stroke-width", 1)
      .attr("stroke-linejoin", "round")
      .attr("stroke-linecap", "round")
      .style("stroke", d => { return color(d.name); })
      .attr("d", d => { return line(d.values); })

    // Server: {Count} text
    server.append("text")
      .datum(d => {
        return {
          name: d.name,
          value: d.values[d.values.length - 1]
        };
      })
      .attr("transform", d => {
        return "translate(" + x(d.value.date) + "," + y(d.value.count) + ")";
      })
      .attr("x", 3)
      .attr("dy", ".35em")
      .style("font-family", "inherit")
      .text(d => {
        return serverNames.get(d.name) + ": " + d.value.count;
      });
  })
};

(function() {
  popchart("#chart")
})();
