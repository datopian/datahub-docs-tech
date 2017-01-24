# Prepare data for Datapackage Registry

Datapackage Registry loads and stores data in common tabular data formats such as CSV and Excel. While the system can work with a range of data structures in these files, due to the flexible modeling scheme of [Data Package](http://specs.frictionlessdata.io/), a minimum set of quality requirements must be met.

## Minimum quality requirements

[TODO] Essentially, the minimum quality requirements are as follows:

- The file must have headers on the first row.
- There must not be any blank rows.
- There must not be any mismatch between the length of a row, and the length of the headers.
- Each column must have a consistent "data type" (date columns should contain dates, amount columns should contain numbers without currency signs or names).

## Ensuring quality

Files added to Datapackage Registry need to meet a certain quality level in the structure of the file, and the schema.

If you use the [CLI](https://github.com/frictionlessdata/dpm-py) to upload files via the command line, the data sources will be checked using the [GoodTables data validator](https://github.com/frictionlessdata/goodtables).

Using these tools, you'll not only be told that the data sources are valid (or not), you'll also get hints on how to address issues in the case of invalid files.

If you have a custom data processing pipeline, or in general, would like to validate your files without using the Packager and CLI, that is entirely possible by using GoodTables directly in your own setup.

## Why is this important?

Datapackage Registry uses a flat file datastore to store the raw data provided by users, with additional information on how to understand that raw data via the Data Package descriptor. From the datastore, other databases are derived, to provide the Datapackage Registry APIs and other related data services. The data quality checks ensure that the ecosystem that reads data out of the datastore can expect the data to be of a reliable quality.

## Walkthroughs

### Checking data quality with the CLI

[TODO]

1. Download the goodtables library, which is a Python package, and can be used as a command line tool. It runs on Python 2 or 3:`pip install goodtables`

2. Ensure goodtables is installed correctly by typing `goodtables` in your shell. You should see something like the following:
![Image 6](https://raw.githubusercontent.com/openspending/docs/master/images/Picture1.png)

3. We want to check the structure of our CSV file. This is done with the following command: `goodtables structure {PATH_TO_FILE}`. See two screenshots below, one with a check that returned structural errors, and one with a check that found the file valid.
![Image 7](https://raw.githubusercontent.com/openspending/docs/master/images/Picture2.png)
![Image 8](https://raw.githubusercontent.com/openspending/docs/master/images/Picture3.png)
