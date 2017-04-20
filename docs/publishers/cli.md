# DPM: The Data Package Manager CLI

- [Getting started](#getting-started)
- [Installation](#installation)
- [Commands](#commands)
- [Configuration](#configuration)
- [Usage](#usage)
    - [Publish](#publish)
    - [Tag](#tag)
    - [Delete](#delete)
    - [Undelete](#undelete)
- [Links](#links)

## Getting started

The dpm is a command-line tool aimed to help publishers to prepare and upload data to the DataHub. With dpm you will be able to:

* Validate your data to ensure its quality
* Publish Data Package
* Tag uploaded Data Package to create historical snapshot
* Remove uploaded Data Package that is no longer needed

## Installation

You can install unstable version directly from the code repository:

```bash
pip install git+https://github.com/frictionlessdata/dpm-py.git
```

## Commands

You can see the latest commands and get help by doing:

```bash
dpm --help
```

You will see output like this:

```bash
Usage: dpm [OPTIONS] COMMAND [ARGS]...

Options:
  --version      Show the version and exit.
  --config TEXT  Use custom config file. Default /home/u1/.dpm/config
  --debug        Show debug messages
  --help         Show this message and exit.

Commands:
  configure     Update configuration options.
  datavalidate  Validate csv file data, given its path.
  delete        Delete Data Package from the registry server.
  publish       Publish Data Package to the registry server.
  purge         Purge Data Package from the registry server.
  tag           Tag Data Package on the server.
  undelete      Undelete Data Package from the registry...
  validate      Validate Data Package in the current dir.
```

## Configuration

Dpm can be configured using `dpm configure` command. It will ask you
to provide username, access_token and server address of DataHub.

The config is stored in `~/.dpm/config`, you can edit it with text editor.
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
dpm publish
```

If your configured *username* and *access_token* are correct, dpm will
upload datapackage.json and all relevant resources to the registry server.

### Tag

To create historical snapshot of your data, you can tag previously uploaded datapackage on the server. Use `dpm tag` command:

```bash
cd datapackage-dir
dpm tag v1.1
```
This will copy the latest version of the Data Package to a separate location in the BitStore. This way you will be able keep a copy of your Data Package at this particular point in time.

### Delete

You have two choices: delete Data Package completely from the server (`purge`) or make the datapackage invisible to everyone except you (`delete`). You can use `dpm purge` and `dpm delete` accordingly:

```bash
cd datapackage-dir
dpm delete
# or purge it completely
dpm purge
```

### Undelete

You can restore your Data Package using `undelete` command.

```bash
dpm undelete
```
Note that this only works on packages with soft delete (`dpm delete`), you can not undelete ones with hard delete (`dpm purge`)

## Links

- [Code repo](https://github.com/frictionlessdata/dpm-py)
