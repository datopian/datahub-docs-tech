# Datapackage Registry Datastore

The Datapackage Registry Datastore is a flat file datastore with source data stored in [Data Packages](http://specs.frictionlessdata.io/).

There is not a great deal to document. The following notes are important to know:

- The Datastore runs from S3, or, an object storage which supports the S3 API.
- The Datastore is the point of truth for data, holding the raw data sources, and the [Data Package](http://specs.frictionlessdata.io/) that describes the sources.
- All data coming into Datapackage Registry first hits the Datastore. From the Datastore, various services read this data and create derived databases to represent the data in certain ways. For example, the data is read into an SQL backend to provide the analytics API, and a search backend for the search API.

## Configuration

In order to use the Datastore, a number of Datapackage Registry components need to be able to read and write from it. In order to do this, we suggest the following setup (those familiar with AWS and S3 may modify aspects of this as desired, as long as the user with the access keys can read and write to the bucket that provides the Datastore).

### AWS account

Setup an AWS account.

### AWS user

You need a user that has permissions to read and write to the bucket. It is best practice to not employ an actual user account for this task, but, rather, set up some user that you use for deployed services, who has only the actual access levels required to perform the needed actions. An example setup is:

- Go to security credentials in AWS and create a new user with a name that helps you remember it is a deployment user. Example: `openspending-robot`
- Get this user's access key, secret key. The access key and secret key are used in the `OS_ACCESS_KEY_ID` and `OS_SECRET_ACCESS_KEY` environment variables respectively.
- Go to that user's permissions and attach an `AmazonS3FullAccess` policy (great place for fine-tuning if you are familiar with AWS)
- Go to S3 and create a bucket that you will use as the OpenSpending Datastore. The name of the bucket is used in the `OS_STORAGE_BUCKET_NAME` environment variable.
- With the S3 bucket created, go to its 'Properties', then 'Permissions', then 'Edit Bucket Policy'. The policy should allow GET access to anyone, like:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AddPerm",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::{YOUR_BUCKET_NAME}/*"
    }
  ]
}
```

- Also in the 'Permissions' section, choose 'Edit CORS Configuration' and use this configuration:

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedMethod>POST</AllowedMethod>
    <ExposeHeader>Content-Range</ExposeHeader>
    <AllowedHeader>*</AllowedHeader>
  </CORSRule>
</CORSConfiguration>
```

### Contributing code

Found a bug? Got neat way to refactor an existing code path? Bursting with ideas to make Datapackage Registry more awesome?

We *can't wait* to see your contributions. Here are a few things that will help:

- All open issues [can be found here](http://github.com/frictionlessdata/dpr-api/issues). If you are working on an existing issue, please let us know by commenting on an issue. Likewise, if you are working on something new, open an issue to let us know.
- We follow a set of [coding standards](https://github.com/okfn/coding-standards), and we have simple examples of those coding standards implemented for [Python](https://github.com/okfn/oki-py) and [Javascript](https://github.com/okfn/oki-js). Please do read before starting.

If anything is unclear, or you just want to talk with other people working on Datapackage Registry, then catch us on [Gitter.im](http://gitter.im/frictionlessdata/chat).

