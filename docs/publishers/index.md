# Publishers

This section of the DataHub documentation is for data publishers. Here you can learn about getting your data ready for loading into DataHub, and how you can interact with your data once it is loaded.

- [Publishing a Data Package](#publishing-a-data-package)
    - [Sign up & get a secret key](#sign-up-&-get-a-secret-key)
    - [Install command line tool](#install-command-line-tool)
    - [Configure](#configure)
    - [Publish a dataset](#publish-a-dataset)
    - [View it online](#view-it-online)


# Publishing a Data Package

## Sign up & get a secret key

You can sign up using your GitHub account. Once you are signed in, you will be redirected to a dashboard, where you can find your secret key (access token).

## Install command line tool

Next you need to install [dpm](cli/) - the data package manager command line tool:

```
$ [sudo] pip install git+https://github.com/frictionlessdata/dpm-py.git
```

## Configure

You will need the secret key (access token) to set your configurations:

```bash
$ dpm configure

> Username:  << your user name >>
> Your access_token:  << you secret key >>
> Server URL: https://www.datapackaged.com
```

Note: server URL may vary depending on application development stag

## Publish a dataset

*We assume you know what a [Data Package](http://specs.frictionlessdata.io/) is.*

Go to a directory where your data package is located and publish it:

```
$ cd your-data-package-directory/
$ dpm publish
```

## View it online

Once your data package is successfully published, you will get an URL to your dataset on the website. Open the URL in your favourite browser and explore it.
