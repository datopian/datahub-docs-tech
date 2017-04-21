## DevOps - Production Deployment

We use various cloud instances for DataHub application. We use AWS S3 and RDS for storing data and metadata, and the application runs on Heroku.

You can create all the instances and deploy app with one simple command, follow the instructions here: https://gitlab.com/datopian/datahub-deploy

### Outline - Conceptually

<div class="mermaid">
graph TD

  user[fa:fa-user User] --> frontend
  frontend[Frontend] --> db[Database]
  frontend --> bits[BitStore - S3]
</div>

### Current Structure

This diagram shows the current deployment architecture.

<div class="mermaid">
graph TD

  user[fa:fa-user User]
  bits[BitStore]
  cloudflare[Cloudflare]

  user --> cloudflare
  cloudflare --> heroku
  cloudflare --> bits
  heroku[Heroku - Flask] --> rds[RDS Database]
  heroku --> bits
</div>

### AWS - Old Structure

We are no longer using AWS in this way. However, we have kept this for historical purposes and in case we return to AWS

<div class="mermaid">
graph TD

  user[fa:fa-user User] --> cloudfront[Cloudfront]
  cloudfront --> apigateway[API Gateway]
  apigateway --> lambda[AWS Lambda - Flask via Zappa]
  cloudfront --> s3assets[S3 Assets]
  lambda --> rds[RDS Database]
  lambda --> bits[BitStore]
  cloudfront --> bits
</div>
