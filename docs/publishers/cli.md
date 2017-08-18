# `data` - the DataHub CLI

[TOC]

# Getting started

`data` is the command-line tool to prepare, push and get data from the DataHub. With `data` you will be able to:

* Push data to the DataHub
* Get data from the DataHub
* Get information about particular data files and datasets (both on the DataHub and off)
* Validate your data to ensure its quality

# Installation

There are two options for installation:

1. Installing pre-built binaries. These have no dependencies and will work "out of the box"
2. Install via npm: if you have node (>= v7) and npm installed you can install via npm

## Installing binaries

1. Go to the [releases page](https://github.com/datopian/datahub-cli/releases)
2. Download the pre-built binary for your platform (MacOS and LinuxOS x64 at present)
3. Move the binary into your `$PATH` e.g. on Mac you could move to `/usr/local/bin/`
 
    ```bash
    mv data-{os-distribution} /usr/local/bin/data
    ```

## Installing via npm

You can also install it from `npm` as follows:

```bash
npm install -g datahub-cli
```


# Usage

You can see the latest commands and get help by doing:

```bash
data help
```

## `push`

Putting data online is one command: `push`.

```bash
data push [FILE-or-DATA-PACKAGE-PATH]
```

**Login befor pushing**: you will need to login (or signup) before pushing:

```
data login
```

This will carry out login / signup entirely from the command line.

