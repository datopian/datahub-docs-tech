#!/bin/bash
MKDOCS_SITE="${HOME}/mkdocs_site"
mkdir $MKDOCS_SITE
git clone -b gh-pages "https://$GH_TOKEN@github.com/frictionlessdata/dpr-docs.git" $MKDOCS_SITE
mkdocs build -d $MKDOCS_SITE
cd $MKDOCS_SITE
git add *
git commit -m "Deployed from travis"
git push origin gh-pages
