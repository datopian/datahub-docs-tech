# Views

- [Introduction](#introduction)
    - [Motivation](#motivation)
    - [Concepts and Background](#concepts-and-background)
- [Examples of using views](#examples-of-using-views)
    - [Simple graph spec](#simple-graph-spec)
    - [Vega graphs](#vega-graphs)
    - [Maps](#maps)
    - [Tables and Transforms](#tables-and-transforms)

## Introduction

### Motivation

Producers and consumers of data [packages] want to have their data presented in tables and graphs -- "views" on the data.

*Why? For a range of reasons -- from simple eyeballing to drawing out key insights.*

<div class="mermaid">
graph LR
  data[Your Data] --> table[Table]
  data --> grap[Graph]

  classDef implemented fill:lightblue,stroke:#333,stroke-width:4px;
  class abc implemented;
</div>

To achieve this we need to provide:

* A tool-chain to create these views from the data.
* A descriptive language for specifying views such as tables, graphs, map.

These requirements are addressed through the introduction of Data Package "Views" and associated tooling.

<div class="mermaid">
graph LR

  subgraph Data Package
    resource[Resource]
    view[View]
    resource -.-> view
  end

  view --> toolchain
  toolchain --> svg["Rendered Graph (SVG)"]
  toolchain --> table[Table]
</div>

We take a "running code" approach -- as in the rest of the Frictionless Data effort. We develop the spec by building a working implementation, and iterate around the spec as we develop. As development progresses the spec crystallizes and becomes ever less subject to change.

Our current implementation efforts focus on provide javascript tools and building a data package registry (DPR).

### Concepts and Background

To generate visualizations you usually want the following 3 types of information:

- metadata: e.g. title of graph, credits etc
- graph: description / specification of the graph itself
- data: specification of data sources for the graph including location and key metadata like types

The data spec itself often consists of three distinct parts:

- "raw / graph data": a spec / description of data exactly in the form needed by the visualization system. This is often a very well defined spec e.g. an array of series.
- locate/describe: a spec of where to get data from e.g. `url` or `data` attribute plus some information on that data such as format and types.
- transform: a spec of how transform external data prior to use e.g. pivoting or filtering it

From this description it should be clear that the latter two data specs -- locate/describe and transform -- are actually generic and independent of the specific graphing library. The only thing the graphing library really needs is a clear description of the "raw" format which it directly consumes. Thus, we can consider a natural grouping of specs as:

- general-metadata - e.g. title of graph, credits etc [provided by e.g. Data Package / define yourself!]
- data: sourcing and transform [provided by e.g. Data Resource]
    - sourcing: how to source data from external sources
    - transform: how to transform data e.g. pivot it, select one field, scale a field etc
- graph description / specification [provided by e.g. Vega]
    - graph data (raw): data as directly consumed by graph spec (usually JSON based if we are talking about JS web-based visualization)

However, in many visualization tools -- including specs like Vega -- these items are combined together. This is understandable as these tools seek to off users a "complete solution". However, **decoupling these parts and having clearly defined interfaces would offer significant benefits**:

* Extensibility: it would be easier to extend and adapt the system. For example, adding new data import options could be done without changing the graph system.
* Composability: we can combine different parts together in different ways. For example, data import and transformation could be used for generating data for tabular display as well as graphing.
* Reusability: we want to reuse existing tools and specifications wherever possible. If we keep the specs relatively separate we can reuse the best spec for each job.
* Reliability: when the system is decoupled it is easier to test and check.

In summary, a smaller pieces, loosely joined makes it easier to adapt and evolve the specs and the associated tooling.

## Examples of using views

In this section, examples of using Data Package views are provided. Each example has a README section with small tutorial.

### Simple graph spec

Simple graph spec is the easiest and quickest way to specify a view in a Data Package. Using simple graph spec publishers can generate graphs, e.g., line and bar charts.

* [Simple Graph Spec Tutorial](https://staging.datapackaged.com/examples/simple-graph-spec)

### Vega graphs

Publishers can also describe graphs using Vega specifications:

* [Vega Graph Spec Tutorial - Yields of Barley](https://staging.datapackaged.com/examples/vega-views-tutorial-grouping)
* [Vega Graph Spec Tutorial - US presidents](https://staging.datapackaged.com/examples/vega-views-tutorial-lines)
* [Vega Graph Spec Tutorial - US Airports](https://staging.datapackaged.com/examples/vega-views-tutorial-topojson)

### Maps

At the moment, we only support `.geojson` format:

* [GeoJSON Tutorial](https://staging.datapackaged.com/examples/geojson-tutorial)

### Tables and Transforms

In the following examples, we demonstrate how transforms can be used in Data Package views. Transformed data will be displayed as table views.

* [Filter & Formula](https://staging.datapackaged.com/examples/transform-examples-on-co2-fossil-global)
* [Sample](https://staging.datapackaged.com/examples/example-sample-transform-on-currency-codes)
* [Aggregate](https://staging.datapackaged.com/examples/transform-example-gdp-uk)
