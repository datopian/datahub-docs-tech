# Platform

The DataHub platform has been designed as a set of loosely coupled components, each performing distinct functions related to the platform as a whole.

- [Architecture](#architecture)
- [Domain Model](#domain-model)
    - [Profile](#profile)
    - [Package](#package)

## Architecture

<div class="mermaid">
graph TD

subgraph Web Frontend
  frontend[Frontend Webapp]
  browse[Browse & Search]
  login[Login & Signup]
  view[Views Renderer]
  frontend --> browse
  frontend --> login
end

subgraph Users and Permissions
  user[User]
  permissions[Permissions]
  authapi[Auth API]
  authzapi[Authorization API]
  login --> authapi
  authapi --> user
  authzapi --> permissions
end

subgraph BitStore
  bitstore["BitStore (S3)"]
  bitstoreapi[BitStore API<br/>put,get]
  bitstoreapi --> bitstore
  browse --> bitstoreapi
end

subgraph MetaStore
  metastore["MetaStore (RDS)"]
  metaapi[MetaStore API<br/>read,search,import]
  metaapi --> metastore
  browse --> metaapi
end

subgraph CLI
  cli[CLI]
end
</div>

* [CLI][cli] - Command Line Interface for publishing [Data Packages](#data-package)
* [Front-end Web Application][web-app] - Core part of platform - API, Login & Sign-Up and Browse & Search (page not yet implemented)
* [Views and Renderer][views] - JS Library responsible for visualization and views on platform

### BitStore

We are preserving the data byte by byte.

- We use AWS S3 instance for storing data
- We use the following URL structure on S3: `bits.{base-domain}.metadata/{publisher}/{data-package}/_v/{version}/data/{resource-name}.csv`

### MetaStore

The MetaStore stores Data Package meta-data along with other management information like publishers, users and permissions.

We use AWS RDS Postgresql database for storing meta-data.

### Users and Permissions

- We are using GitHub auth API for authenticating users on our platform. See more information on [authentication page][auth-page]
- We have a standard access control matrix with 3 axes for authorization. See more information on
[authorization page][authz-page]

[auth-page]: /developers/authentication
[authz-page]: /developers/authorization
[cli]: /publishers/cli
[views]: /developers/view
[web-app]:

## Domain model

There are two main concepts to understand in DataHub domain model - [Profile](#profile) and [Package](#package)

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
