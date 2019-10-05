import * as d3 from "d3";

export default function (selector, options = {}) {
  console.log(selector, options, d3);

  let data = {
    y: "Maximum",
    series: [{ name: "Series", values: [1, 2, 3] }],
    dates: ["2000-01-01", "2000-02-01", "2000-03-01"]
  }

  const margin = ({ top: 20, right: 20, bottom: 30, left: 30 })
  const width = 400;
  const height = 400;

  const svg = d3.select(selector)
    .append("svg")
    .attr("viewBox", [0, 0, width, height]);

  // Scales
  const x = d3.scaleUtc()
    .domain(d3.extent(data.dates))
    .range([margin.left, width - margin.right])

  const y = d3.scaleLinear()
    .domain([0, d3.max(data.series, d => d3.max(d.values))]).nice()
    .range([height - margin.bottom, margin.top])

  // Axes
  const xAxis = g => g
    .attr("transform", `translate(0,${height - margin.bottom})`)
    .call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))

  const yAxis = g => g
    .attr("transform", `translate(${margin.left},0)`)
    .call(d3.axisLeft(y))
    .call(g => g.select(".domain").remove())
    .call(g => g.select(".tick:last-of-type text").clone()
      .attr("x", 3)
      .attr("text-anchor", "start")
      .attr("font-weight", "bold")
      .text(data.y))

  svg.append("g")
    .call(xAxis);

  svg.append("g")
    .call(yAxis);

  // Shapes
  const line = d3.line()
    .defined(d => !isNaN(d))
    .x((d, i) => x(data.dates[i]))
    .y(d => y(d))

  svg.append("g")
    .attr("fill", "none")
    .attr("stroke", "steelblue")
    .attr("stroke-width", 1.5)
    .attr("stroke-linejoin", "round")
    .attr("stroke-linecap", "round")
    .selectAll("path")
    .data(data.series)
    .join("path")
    .style("mix-blend-mode", "multiply")
    .attr("d", d => line(d.values));
}
