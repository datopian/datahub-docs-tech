# Publishers

This section of the DataHub documentation is for data publishers. Here you can learn about getting your data ready for loading into DataHub, and how you can interact with your data once it is loaded.

- [Getting data in](#getting-data-in)
    - [Prepare](#prepare)
    - [Package](#package)
    - [Upload](#upload)
    - [Use](#use)
- [CLI](#dpm-the-data-package-manager-cli)
    - [Installation](#installation)
    - [Commands](#commands)
    - [Configuration](#configuration)
    - [Usage](#usage)
        - [Publish](#publish)
        - [Tag](#tag)
        - [Delete](#delete)
  - [Links](#links)

# Getting data in

## Prepare

DataHub loads and stores data in various formats according to the [Data Package specification](http://specs.frictionlessdata.io/), including common data formats such as CSV and JSON.

## Package

DataHub "understands" the contents of a source data file via another "descriptor" called a [Data Package](http://specs.frictionlessdata.io/). In fact, the DataHub Datastore does not strictly store any old data file, but rather, it stores Data Packages, being a collection of data sources and a `datapackage.json` descriptor file.

## Upload

It is possible to upload Data Packages into the DataHub with dpm CLI (or via a web site - in the future). See [section below](#dpm-the-data-package-manager-cli) to learn more.

## Use

Once your data is loaded into DataHub, you can interact with the data in a number of ways, including via API, raw files from the Datastore, and various views on the data.

# DPM: The Data Package Manager CLI

The dpm is a command-line tool aimed to help publishers to prepare and upload data to the DataHub. With dpm you will be able to:

* Validate your data to ensure its quality
* Publish Data Package
* Tag uploaded Data Package to create historical snapshot
* Remove uploaded Data Package that is no longer needed

## Installation

You can install unstable version directly from the code repository:

```
[sudo] pip install git+https://github.com/frictionlessdata/dpm-py.git
```

## Commands

You can see the latest commands and get help by doing:
```
dpm --help
```
You will see output like this:
```
Usage: dpm [OPTIONS] COMMAND [ARGS]...

Options:
  --version      Show the version and exit.
  --config TEXT  Use custom config file. Default /home/u1/.dpm/config
  --debug        Show debug messages
  --help         Show this message and exit.

Commands:
  configure     Update configuration options.
  datavalidate  Validate csv file data, given its path.
  delete        Delete datapackage from the registry server.
  publish       Publish datapackage to the registry server.
  purge         Purge datapackage from the registry server.
  tag           Tag datapackage on the server.
  undelete      Undelete datapackage from the registry...
  validate      Validate datapackage in the current dir.
```

## Configuration

Dpm can be configured using `dpm configure` command. It will ask you
to provide username, access_token and server address of DataHub.

The config is stored in `~/.dpm/config`, you can edit it with text editor.
Simple example config file can look like this:

```
username = myname
access_token = mykey
server = https://staging.datapackaged.com
```

## Usage

### Publish

To publish a Data Package, go to the Data Package directory (with `datapackage.json`) and
run:
```
dpm publish
```
If your configured *username* and *access_token* are correct, dpm will
upload datapackage.json and all relevant resources to the registry server.

[TODO] add details in the [upload](upload/) section

### Tag

To create historical snapshot of your data, you can tag previously uploaded datapackage on the server. Use `dpm tag` command:
```
cd datapackage-dir
dpm tag v1.1
```
This will copy the latest version of the Data Package to a separate location in the BitStore. This way you will be able keep a copy of your Data Package at this particular point in time.

### Delete

You have two choices: delete datapackage completely from the server (`purge`) or make the datapackage invisible to everyone except you (`delete`). You can use `dpm purge` and `dpm delete` accordingly:
```
cd datapackage-dir
dpm delete
# or purge it completely
dpm purge
```

## Links

- [Code repo](https://github.com/frictionlessdata/dpm-py)
