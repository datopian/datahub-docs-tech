# Developers

This section of the DataHub documentation is for developers. Here you can learn about the design of the platform and how to get DataHub running locally or on your own servers, and the process for contributing enhancements and bug fixes to the code.

[![Gitter](https://img.shields.io/gitter/room/frictionlessdata/chat.svg)](https://gitter.im/frictionlessdata/chat)

We use following repositories on GitHub and GitLab for our platform:

* [DPR API][dpr-api] - API and web-application
* [DPR DEPLOY][dpr-deploy] - Automated deployment of application
* [DPR JS][dpr-js] - Visualizations and front-end JS
* [DPR DOCS][dpr-docs] - Documentations

[dpr-api]: https://github.com/frictionlessdata/dpr-api
[dpr-deploy]: https://gitlab.com/datopian/datahub-deploy
[dpr-js]: https://github.com/frictionlessdata/dpr-js
[dpr-docs]: https://github.com/frictionlessdata/dpr-docs

<div class="mermaid">
graph LR

subgraph Repos
  dprapi[DPR API]
  dprjs[DPR JS]
  dprdeploy[DPR Deploy]
  dprdocs[DPR Docs]
  dprjs --submodule--> dprapi
end

subgraph Sites
  dhio[xxx.dh.io]
  dhdocs[docs.dh.io]
  dprdocs --> dhdocs
end

deploy((Deploy))
dprapi --> deploy
deploy --> dhio
dprdeploy --> deploy
</div>

## Install

To install the platform locally for development purposes, please follow the instructions here:

https://github.com/frictionlessdata/dpr-api

## Deploy

For deployment of the application in a production environment, please see [the deploy page][deploy].

[deploy]: deploy/

## Authorization

The authorization set up enables system to restricts user permission to execute.

[Authorization docs](authorization/)

## Authentication

Some DataHub API methods require client to provide user identity. API Client can use JWT token to perform authenticated requests.

[Authentication docs](authentication/)

## CLI

The DataHub CLI (dpm) is a Python lib and command line interface to interact with an DataHub instance.

[CLI code](https://github.com/frictionlessdata/dpm-py)
