import * as d3 from "d3";
import { group } from "d3-array";



export default function (selector, options = {}) {
  // Config
  const width = options.width | 600;
  const height = options.width | 300
  const margin = ({ top: 20, right: 80, bottom: 20, left: 40 })

  // Server ID -> Name mapping
  const serverNames = new Map();
  serverNames.set(0, "Frostfell")
  serverNames.set(1, "WintersEbb")

  // Date formatting utility function
  const formatDate = d3.timeParse("%Y/%m/%d")

  console.log("about to call d3.json...");
  d3.json("/populations.json").then(json => {
    console.log(json)
    let data = json.map(d => {
      return {
        "server": d.id,
        "date": formatDate(d.date),
        "count": d.count
      }
    });

    // Re-format data group-wise
    let grouped = group(data, d => d.server);

    console.log(grouped);

    // Scales
    const x = d3.scaleUtc()
      .domain(d3.extent(data, d => d.date))
      .range([margin.left, width - margin.right])

    const y = d3.scaleLinear()
      .domain([0, d3.max(data, d => d.count)]).nice()
      .range([height - margin.bottom, margin.top])

    const color = d3.scaleOrdinal()
      .domain(Array.from(grouped.keys()))
      .range(d3.schemeCategory10);

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

    const servers = color.domain().map(function (key) {
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
      .style("stroke", function (d) { return color(d.name); })
      .attr("d", function (d) { return line(d.values); })

    // Server: {Count} text
    server.append("text")
      .datum(function (d) {
        return {
          name: d.name,
          value: d.values[d.values.length - 1]
        };
      })
      .attr("transform", function (d) {
        return "translate(" + x(d.value.date) + "," + y(d.value.count) + ")";
      })
      .attr("x", 3)
      .attr("dy", ".35em")
      .style("font-family", "inherit")
      .text(function (d) {
        return serverNames.get(d.name) + ": " + d.value.count;
      });
  })
}
