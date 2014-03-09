d3.xhr("http://feed.labs.orcid-eu.org/" + orcid + ".yml", function(error, request) {
  var profile = jsyaml.safeLoad(request["response"]);
  var references = profile["references"];

  if (error) {
    d3.select("div#biography").append("p")
      .text("No biography found.");
    if (references.length == 0) {
      d3.select("div#year").append("div")
        .attr("class", "col-md-7")
        .attr("id", "year-label");
      d3.select("div#year-label").append("p")
        .attr("class", "muted")
        .text("No publications found.");
        return
    }
  }

  d3.select("div#biography").append("p")
    .text(profile["biography"]);

  var nest = d3.nest()
    .key(function(d) { return d["issued"]["date-parts"][0][0]; })
    .rollup(function(d) { return d.length; })
    .entries(references);

  // extract the publication year
  // references = references.map(function(d) { return { "year": d["issued"]["date-parts"][0][0],
  //                                        "type": d["type"],
  //                                        "author_number": d["author"].length }});

  var l = 20; // left margin
  var r = 50; // right margin
  var t = 50;  // top margin
  var w = 15; // width of each bar
  var h = 100; // height
  var first_year = d3.min(nest, function(d) { return d.key; });
  var this_year = (new Date).getFullYear();
  var width = w * (this_year - first_year) + l + r;
  var length = references.length;
  var format_number = d3.format("d")

  d3.select("div#year").append("div")
    .attr("class", "col-md-3 text-center")
    .attr("id", "year-label");
  d3.select("div#year-label").append("h2")
    .attr("class", "signpost")
    .attr("id", "year-signpost")
    .text(length);
  d3.select("div#year-label").append("div")
    .attr("class", "year-label")
    .text("Publications since " + format_number(first_year));
  d3.select("div#year").append("div")
      .attr("class", "col-md-4")
      .attr("id", "year-chart");

  var chart = d3.select("div#year-chart").append("svg")
    .attr("width", width)
    .attr("height", h + t )
    .attr("class", "chart")
    .append("g")
    .attr("transform", "translate(20,20)");
  var x = d3.time.scale()
    .domain([first_year, this_year])
    .range([0, (w + 1) * (this_year - first_year)]);
  var y = d3.scale.linear()
    .domain([0, d3.max(nest, function(d) { return d.values; })])
    .range([0, h]);
  chart.selectAll("rect")
    .data(nest)
    .enter().append("rect")
    .attr("fill", "#1abc9c")
    .attr("x", function(d) { return x(d.key); })
    .attr("y", function(d) { return h - y(d.values); })
    .attr("width", w)
    .attr("height", function(d) { return y(d.values); });
  chart.append("line")
    .attr("x1", 0)
    .attr("x2", (w + 1) * (this_year - first_year) + w - 1)
    .attr("y1", h)
    .attr("y2", h)
    .attr("class", "line");
  chart.selectAll("rect").each(
    function(d,i){ $(this).tooltip({title: format_number(d.values) + " in " + d.key, container: "body"});
  });
});
