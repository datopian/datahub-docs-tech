# Table of Contents

This section of the Datapackage Registry documentation is for developers. Here you can learn about the design of the platform, and how to get Datapackage Registry running locally or on your own servers, and the process for contributing enhancements and bug fixes to the code.

- [Getting started](#getting-started)
- [Platform](platform/)
- [Datastore](datastore/)
- [API](api/)
- [CLI](cli/)
- [Authorization](authorization/)
- [Authentication](authentication/)

# Getting started

Let's get started then! If you want to get the whole Datapackage Registry platform running locally, or deployed to your own servers, then go straight to the [platform](platform/) section of the documentation. For details on distinct components, go to the appropriate section from the list below.

### Platform

Datapackage Registry as a complete platform is run as a service on amazon. Configurations are available to get running quickly on a local machine, or a remote server for production use.

- [Platform docs](platform/)

### Datastore

The Datapackage Registry uses flat file datastore to store uploaded [Data Packages](http://specs.frictionlessdata.io/). Follow this instructions to set it up.

- [Datastore docs](datastore/)

### API

The Datapackage Registry API offers a rich suite of methods to query the database.

- [API docs](api/)
- [API code](https://github.com/frictionlessdata/dpr-api)

### Authorization
The authorization set up enables system to restricts user permission to execute.

- [Authorization docs](authorization/)

### Authentication

Some Datapackage Registry API methods require client to provide user identity. API Client can use jwt token to perform authenticated requests.

- [Authentication docs](authentication/)

### CLI

The Datapackage Registry CLI (dpmpy) is a Python lib and command line interface to interact with an Datapackage Registry instance.

- [CLI docs](cli/)
- [CLI code](https://github.com/openspending/dpm-py)
