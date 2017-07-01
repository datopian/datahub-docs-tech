# DATA: The Data Package Manager CLI

- [Getting started](#getting-started)
- [Installation](#installation)
- [Commands](#commands)
- [Configuration](#configuration)
- [Usage](#usage)
    - [Publish](#publish)
    - [Download](#download)
    - [Delete](#delete)
    - [Information](#information)
    - [Normalize](#normalize)
    - [Validate](#validate)
    - [Configuration](#configuration)
    
- [Links](#links)

## Getting started

The data is a command-line tool aimed to help publishers to prepare and upload data to the DataHub. With data you will be able to:

* Publish Data Package to DataHub
* Get Data Package from DataHub
* Remove uploaded Data Package from DataHub
* Get information about particular Data Package
* Normalize Data Package according to the specs
* Validate your data to ensure its quality
* Set up configuration file in order to publish

## Installation

### Installing binaries without npm

On the [releases](https://github.com/datopian/datahub-cli/releases) page, you can download pre-built binaries for MacOS and LinuxOS x64. You may need to put the pre-built binary in the bin directory (e.g.: /usr/local/bin/).
 
```bash
mv path/to/data-{os-distribution} /usr/local/bin/data
```

### Installing from npm

You can also install it from [npm]() as follows:
`npm install -g data`

## Commands

You can see the latest commands and get help by doing:

```bash
data --help
```

The output of the help command:

```bash
❒ data [options] <command> <args>

Commands:
  DataHub:
    push        [path]        Push data to the DataHub
    get         [pkg-id]      Get data from DataHub
    purge       [owner/name]  Permanently deletes data from DataHub
  Data Package specific:
    info        [pkg-id]      Get info on data
    normalize                 Normalize datapackage.json
    validate                  Validate Data Package structure

  Administrative:
    config                    Set up configuration
    help        [cmd]         Show help on cmd

Options:
-h, --help              Output usage information
-v, --version           Output the version

```

## Configuration

Data can be configured using `data config[ure]` command. It will ask you to provide a username, secretToken, server and bitStore addresses of DataHub.

The config is stored in `~/.datahub/config`, you can edit it with text editor.
Simple example config file can look like this:

```
username = myname
access_token = mykey
server = server URL for publishing Eg: https://www.datapackaged.com
```

## Usage

### Publish

To publish a Data Package, go to the Data Package directory (with `datapackage.json`) and
run:

```bash
data push
```

If your configured *username* and *secretToken* are correct, data will
upload datapackage.json and all relevant resources to the DataHub server.

### Get

To get Data Package run the following command:
```bash
data get <publisher>/<package>
```
New Data Package will be downloaded into current working directory. 

### Delete

To delete permanently Data Package from DataHub, you can use `dpm purge` command:

```bash
data purge
```

### Information

You can get information about particular Data Package

```bash
data info
```

### Normalize

To normalize Data Package descriptor according to the specs

```bash
data norm[alize] [path]
```
### Validate

To validate Data Package descriptor against schema

```bash
data validate [path | URL]
```
### Configuration

To set up configuration file:
```bash
data config[ure]
```

## Links

- [Code repo](https://github.com/datahq/datahub-cli)
