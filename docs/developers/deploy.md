# Deploy

We use various cloud instances for DataHub application. We use AWS S3 and RDS for storing data and metadata, and the application runs on Heroku.

<div class="mermaid">
graph TD

  user[fa:fa-user User] --> frontend
  frontend[Frontend] --> db[Database]
  frontend --> bits[BitStore - S3]
</div>

You can create all the instances and deploy app with one simple command, follow the instructions here: https://gitlab.com/datopian/datahub-deploy
