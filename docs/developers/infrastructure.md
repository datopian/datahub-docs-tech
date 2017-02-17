# Infrastructure Setup

The whole infrastructure of Data Package Registry is built on AWS services.

## Domain and certificate setup

Suppose you want to use this primary domain: **datapackaged.com**

We mainly have 2 parts:

- AWS API Gateway - primary domain [datapackaged.com]
- S3 - for BitStore and static files

  - Static Files [static.datapackaged.com]
  - BitStore for raw Data Packages [bits.datapackaged.com]

### Api Gateway:

For API Gateway to have a custom domain we have to add generated certificates:

- Certificate body
- Certificate private key
- Certificate chain

We use ``zerossl`` to generate SSL certificate.
The full process is described here:
<https://www.pandastrike.com/posts/20160613-ssl-cert-aws-api-gateway-zerossl-letsencrypt>

Once we add the certs in API Gateway it will generate a cloudfront distribution.

We need to add the ```cloudfront domain``` as CNAME of the external domain provider.

### S3

- External domain name([bits.staging.datapackaged.com)
- This external domain resolves to cloudfront [*.cloudfront.com]
- Cloudfront resolves to "S3 Bucket (*.s3.amazonaws.com)

In cloud front we can use AWS generated certificates.

NOTE: One point to mention: You can use a certificate stored in AWS Certificate Manager (ACM) in the US East
(N. Virginia) Region, or you can use a certificate stored in IAM.

#### Building Cloudfront

- Origin Domain Name= <bucketname>.s3.amazonaws.com

Note: Bucket name can not have "." in it, e.g. abc.bcd.mybucket

- CNAME= {The custom domain name you want to implement}
- Certificate= {Cert generated in AWS Certificate manager in US East(N. Virginia)}
