# Platform

The DataHub platform has been designed as a set of loosely coupled components, each performing distinct functions related to the platform as a whole.

- [Architecture](#architecture)
- [Domain Model](#domain-model)
    - [Profile](#profile)
    - [Package](#package)

## Architecture

<div class="mermaid">

graph TD


  cli((CLI fa:fa-user))
  auth[Auth Service]
  cli --login--> auth
  
	
	cli --store--> raw[Raw Store API<br>+ Storage]  
  
	cli --package-info--> pipeline-store
  raw --data resource--> pipeline-runner
  
  pipeline-store -.generate.-> pipeline-runner
	
  pipeline-runner --> package[Package Storage]
	package --api--> frontend[Frontend]
  frontend --> user[User fa:fa-user]
  

  
  package -.publish.->metastore[MetaStore]
  pipeline-store -.publish.-> metastore[MetaStore]
  metastore[MetaStore] --api--> frontend
  
</div>


* [DataHub-CLI][cli] - Command Line Interface for publishing [Data Packages](#data-package)
* [Front-end Web Application][web-app] - Core part of platform - Login & Sign-Up and Browse & Search Datasets
* [Views and Renderer][views] - JS Library responsible for visualization and views on platform

### Raw Storage

We first save all raw files before sending to pipeline-runner.
**Pipeline-runner** is a service that runs the data package pipelines. It is used to normalise and modify the data before it is displayed publicly

- We use AWS S3 instance for storing data

### Package Storage

We store files after passing pipeline-runner

- We use AWS S3 instance for storing data


### BitStore

We are preserving the data byte by byte.

- We use AWS S3 instance for storing data


### MetaStore

The MetaStore stores Data Package meta-data along with other management information like publishers, users and permissions.

We use AWS RDS Postgresql database for storing meta-data.

[cli]: /publishers/cli
[views]: /developers/views
[web-app]: http://datahub.io/

## Domain model

There are two main concepts to understand in DataHub domain model - [Profile](#profile) and [Package](#data-package)

<div class="mermaid">
graph TD

pkg[Data Package]
resource[Resource]
file[File]
version[Version]
user[User]
publisher[Publisher]

subgraph Package
  pkg --0..*--> resource
  resource --1..*--> file
  pkg --> version
end

subgraph Profile
  publisher --1..*--> user
  publisher --0..*--> pkg
end
</div>

### Profile

Set of an authenticated and authorized entities like publishers and users. They are responsible for publishing, deleting or maintaining data on platform.

**Important:** Users do not have Data Packages, Publishers do. Users are *members* of Publishers.

#### Publisher

Publisher is an organization which "owns" Data Packages. Publisher may have zero or more Data Packages. Publisher may also have one or more user.

#### User

User is an authenticated entity, that is member of Publisher organization, that can read, edit, create or delete data packages depending on their permissions.

### Package

Set of Data Packages published under publisher name.

#### Data Package

A Data Package is a simple way of “packaging” up and describing data so that it can be easily shared and used. You can imagine as collection of data and and it's meta-data ([datapackage.json][datapackage.json]), usually covering some concrete topic Eg: *"Gold Prices"* or *"Population Growth Rate In My country"* etc.

Each Data Package may have zero or more resources and one or more versions.

**Resources** - think like "tables" - Each can map to one or more physical files (usually just one). Think of a data table split into multiple CSV files on disk.

**Version of a Data Package** - similar to git commits and tags. People can mean different things by a "Version":

* Tag - Same as label or version - a nice human usable label e.g. *"v0.3"*, *"master"*, *"2013"*
* Commit/Hash - Corresponds to the hash of datapackage.json, with that datapackage.json including all hashes of all data files

We interpret Version as *"Tag"* concept. *"Commit/Hash"* is not supported

[datapackage.json]: http://frictionlessdata.io/guides/data-package/#datapackagejson
