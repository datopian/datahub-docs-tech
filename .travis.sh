#!/bin/bash
MKDOCS_SITE="${HOME}/mkdocs_site"
mkdir $MKDOCS_SITE
git clone -b gh-pages "https://github.com/${TRAVIS_REPO_SLUG}" $MKDOCS_SITE
mkdocs build -d $MKDOCS_SITE
cd $MKDOCS_SITE
git remote set-url origin "https://$GH_TOKEN@github.com/${TRAVIS_REPO_SLUG}.git"
git add *
git commit -m "Deployed from travis"
git push origin gh-pages
