# DPM: The Data Package Manger CLI

The dpm is a command-line tool aimed to help publishers to prepare and upload data to the Data Package Registry. With dpm you will be able to:

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
dpmpy --help
```
You will see output like this:
```
Usage: dpmpy [OPTIONS] COMMAND [ARGS]...

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

Dpm can be configured using `dpmpy configure` command. It will ask you
to provide username, access_token and server address of Data Package Registry.

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
dpmpy publish
```
If your configured *username* and *access_token* are correct, dpm will
upload datapackage.json and all relevant resources to the registry server.

[TODO] add details in the [upload](upload/) section

### Tag

To create historical snapshot of your data, you can tag previously uploaded datapackage on the server. Use `dpmpy tag` command:
```
cd datapackage-dir
dpmpy tag v1.1
```
This will copy the latest version of the Data Package to a separate location in the BitStore. This way you will be able keep a copy of your Data Package at this particular point in time.

### Delete

You have two choices: delete datapackage completely from the server (`purge`) or make the datapackage invisible to everyone except you (`delete`). You can use `dpmpy purge` and `dpmpy delete` accordingly:
```
cd datapackage-dir
dpmpy delete
# or purge it completely
dpmpy purge
```

## Links

- [Code repo](https://github.com/frictionlessdata/dpm-py)

