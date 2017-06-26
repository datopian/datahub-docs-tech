# DataHub Documentation
[![Build Status](https://travis-ci.org/frictionlessdata/dpr-docs.svg?branch=master)](https://travis-ci.org/frictionlessdata/dpr-docs)
[![Gitter](https://img.shields.io/gitter/room/frictionlessdata/chat.svg)](https://gitter.im/frictionlessdata/chat) [![Issues](https://img.shields.io/badge/issue-tracker-orange.svg)](https://github.com/frictionlessdata/dpr-docs/issues)

This repository holds the documentation for DataHub. The documentation is online:

https://frictionlessdata.github.io/dpr-docs

# Install

We use mkdocs http://www.mkdocs.org

1. You need to have python and pip installed
2. Run `pip install -r requirements.txt` (we differ from mkdocs instructions http://www.mkdocs.org/#installation because we have some extra dependencies)

# Building the site locally

```
mkdocs serve
```

# Deploy

Deploy is done automatically to the `gh-pages` branch by Travis. See Travis files for details.
