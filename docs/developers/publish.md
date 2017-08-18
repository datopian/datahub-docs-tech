# Publish

Explanation of DataHub publishing flow from client and back-end perspectives.

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

## Client Perspective

Publishing flow takes the following steps and processes to communicate with DataHub API:

<div class="mermaid">
sequenceDiagram
Upload Agent CLI->>Upload Agent CLI: Check Data Package valid
Upload Agent CLI-->>Auth(SSO): login
Auth(SSO)-->>Upload Agent CLI: JWT token
Upload Agent CLI->>RawStore API: upload using signed url
RawStore API->>Auth(SSO): Check key / token
Auth(SSO)->>RawStore API: OK / Not OK
RawStore API->>Upload Agent CLI: success message
Upload Agent CLI->>pipeline store: package info
pipeline store->>Upload Agent CLI: OK / Not OK
pipeline store->>pipeline runner: generate
RawStore API->>pipeline runner: data resource
pipeline runner->>Package Storage: generated
Package Storage->>Metadata Storage API: publish
pipeline store->>Metadata Storage API: publish
Metadata Storage API->>Upload Agent CLI: OK / Not OK
</div>
<br>

* Upload API - see `POST /source/upload` in *source* section of [API][api]
* Authentication API - see `GET /auth/check` in *auth* section of [API][api].
* Authorization API - see `GET /auth/authorize` in *auth* section of [API][api].


See example [code snippet in DataHub CLI][publish-code]

[api]: /developers/api/
[publish-code]: https://github.com/datahq/datahub-cli/blob/b869d38073248903a944029cf93eddf3ef50001a/bin/data-push.js#L34

[api]: /developers/api/

