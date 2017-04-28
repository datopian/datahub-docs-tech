# Views

To render Data Packages in browsers we use DataHub views written in JavaScript. The module implemented in ReactJS framework and it can render tables, maps and various graphs using third-party libraries.

<div class="mermaid">
  graph TD

  url["metadata URL passed from back-end"]
  dp-js[datapackage-js]
  dprender[datapackage-render-js]
  table["table view"]
  chart["graph view"]
  hot[HandsOnTable]
  map[LeafletMap]
  vega[Vega]
  plotly[Plotly]
  browser[Browser]

  url --> dp-js
  dp-js --fetched dp--> dprender
  dprender --spec--> table
  table --1..n--> hot
  dprender --geojson--> map
  dprender --spec--> chart
  chart --0..n--> vega
  chart --0..n--> plotly
  hot --table--> browser
  map --map--> browser
  vega --graph--> browser
  plotly --graph--> browser
</div>

Notice that DataHub views render a table view per tabular resource. If GeoJSON resource is given, it renders a map. Graph views should be specified in `views` property of a Data Package.


## Links

* [dpr-js repo][dpr-js]
* [datapackage-render-js][dprender]
* [views specification and analysis][views]

[dpr-js]: https://github.com/frictionlessdata/dpr-js
[dprender]: https://github.com/frictionlessdata/datapackage-render-js
[views]: https://hackmd.io/JwEwjGDMCGBMsFoBsAWAHJBLhmggRgAzCbDDRkgCsAZgKaw35A==
