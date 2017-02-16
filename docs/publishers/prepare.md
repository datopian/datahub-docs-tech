# Prepare data for Data Package Registry

Data Package Registry loads and stores data in CSV format. While the system can work with a range of data structures in these files, due to the flexible modeling scheme of [Data Package](http://specs.frictionlessdata.io/), a minimum set of quality requirements must be met.

## Why is this important?

Data Package Registry uses a flat file datastore to store the raw data provided by users, with additional information on how to understand that raw data via the Data Package descriptor. From the datastore, other databases are derived, to provide the Data Package Registry APIs and other related data services. The data quality checks ensure that the ecosystem that reads data out of the datastore can expect the data to be of a reliable quality.

## Ensuring quality

Files added to Data Package Registry need to meet a certain quality level in the structure of the file, and the schema.

If you use the [dpmpy](https://github.com/frictionlessdata/dpm-py) to upload files via the command line, the data sources will be checked using the [GoodTables data validator](https://github.com/frictionlessdata/goodtables) before being published. Also you can explicitly validate any Data Package or csv file with `dpmpy datavalidate` command:
```
# validate single file
dpmpy datavalidate data/file.csv

# validate whole Data Package
cd datapackage-dir
dpmpy datavalidate
```

If you have a custom data processing pipeline, or in general, would like to validate your files without using the CLI, that is entirely possible by using GoodTables directly in your own setup.

Using these tools, you'll not only be told that the data sources are valid (or not), you'll also get hints on how to address issues in the case of invalid files.

## Minimum quality requirements

[TODO] Essentially, the minimum quality requirements are as follows:

- The file must have headers on the first row.
- There must not be any blank rows.
- There must not be any mismatch between the length of a row, and the length of the headers.
- Each column must have a consistent "data type" (date columns should contain dates, amount columns should contain numbers without currency signs or names).
