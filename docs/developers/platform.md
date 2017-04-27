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
