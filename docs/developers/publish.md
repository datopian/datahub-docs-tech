# Publish

Explanation of DataHub system workflow from client and back-end perspectives.

## Client Perspective

Publishing flow takes the following steps and processes to communicate with DataHub API:

<div class="mermaid">
sequenceDiagram
Upload Agent CLI->>Upload Agent CLI: Check Data Package valid
Upload Agent CLI-->>Auth(SSO): Get Session Token (Sends base auth)
Auth(SSO)-->>Upload Agent CLI: session token
Upload Agent CLI->>BitStore Upload Auth: Get BitStore Upload token [send session token]
BitStore Upload Auth->>Auth(SSO): Check key / token
Auth(SSO)->>BitStore Upload Auth: OK / Not OK
BitStore Upload Auth->>Upload Agent CLI: S3 auth Token
Upload Agent CLI->>Data Storage (S3 Raw): Send file plus token
Data Storage (S3 Raw)->>Upload Agent CLI: OK / Not OK
Upload Agent CLI->>MetaData Storage API: Finalize (After all data uploaded)
MetaData Storage API->>Upload Agent CLI: OK / Not OK
</div>
<br>

* Upload API - see `POST /api/package/upload` in *package* section of [API][api]
* Authentication API - see `POST /api/auth/token` in *auth* section of [API][api]. Read more [about authentication][auth-docs]
* [Authorization API][authz] - see `POST /api/datastore/authorize` in *package* section of [API][api]. Read more [about authorization][authz-docs]

See example [code snippet in dpm-py][publish-code]

[api]: /developers/api/
[auth-docs]: /developers/authentication/
[authz-docs]: /developers/authorization/
[publish-code]: https://github.com/frictionlessdata/dpm-py/blob/master/dpm/client/__init__.py#L120

<br>

## Back-end perspective

DataHub Metadata and Data Flow

* Pink = service we build
* Blue = external service
* Dark gray = not yet implemented

<div class="mermaid">
graph TD

user[Publisher fa:fa-user]
upload-api["Upload API (S3 API)"]
bitstore(Bitstore S3)
metaingestor[Meta Ingestor]
dataingestor[Data Ingestor]
metastore("Metastore (RDS)")
readapi[Read API]
dataproxy["DataProxy (convert raw data to json on the fly)"]
datastore["Datastore (RDS)"]
s3readapi[S3 Get API]
readuser[Consumer fa:fa-user]

user --s3 signed upload url--> upload-api
upload-api --> bitstore
bitstore --> metaingestor
metaingestor --> metastore
metastore --> readapi
bitstore -.-> dataproxy
bitstore -.-> dataingestor
dataingestor -.-> datastore
datastore -.-> readapi
bitstore --> s3readapi
s3readapi --> readuser
dataproxy -.-> readuser
readapi --> readuser

  classDef extservice fill:lightblue,stroke:#333,stroke-width:4px;
  classDef notimplemented fill:darkgrey,stroke:#bbb,stroke-width:1px;
  classDef service fill:pink,stroke:#333,stroke-width:4px;
  class datastore,dataingestor,dataproxy notimplemented;
  class bitstore,metastore,s3readapi extservice;
  class readapi service;
</div>

* [Authentication][auth-docs]
* [Authorization][authz-docs]
* [BitStore][bitstore] - page not yet implemented
* [DataStore][datastore] - page not yet implemented

[bitstore]:
[datastore]:
