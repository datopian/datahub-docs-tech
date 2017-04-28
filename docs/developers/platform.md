## Domain model

#### Data Package

Each Data Package (DataSet) may have zero or more resources and one or more versions. Data Package is owned by Publisher.

**Resources** - think "tables" - Each can map to one or more physical files (usually just one). Think of a data table split into multiple CSV files on disk.

**Version of a Data Package** - similar to git commits and tags. People can mean different things by a "Version":

* Tag - Same as label or version - a nice human usable label e.g. "v0.3", "master", "2013"
* Commit/Hash - Corresponds to the hash of datapackage.json, with that datapackage.json including all hashes of all data files

We interpret Version as "Tag" concept. *Commit/Hash" is not supported

#### Publisher

**Publisher** is an organization which "owns" Data Packages. Publisher may have zero or more Data Packages. Publisher May also have one or more user.

#### User

User is an authenticated entity, that is member of Publisher organization.

**Important:** Users do not have Data Packages, Publishers do. Users are *members* of Publishers.

<div class="mermaid">
graph TD

pkg[Package]
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

## Overall Architecture

Our platform architecture is built on several different components:

* [CLI][dpm-py] - Command Line Interface
* [Front-end Web Application][dpr-api] - API, Login & Sign-Up and Browse & Search
* [Views and Renderer][dpr-js] - Graphs, Charts, Tables and other visualization tools

[dpr-api]: https://github.com/frictionlessdata/dpr-api
[dpr-js]: https://github.com/frictionlessdata/dpr-js
[dpm-py]: https://github.com/frictionlessdata/dpm-py

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
