#!/bin/sh
set -x 


setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}


upload_files() {
  echo $(pwd)
  git remote add origin-pages https://${GH_TOKEN}@github.com/ldenman/elisp-sandbox.git > /dev/null 2>&1
  git fetch origin-pages
#  
#  mkdir -p images2
#  git status
#  var=`$EMACS_VERSION`|tr . -
#  find images -name "*$var*"|xargs -I {} mv {} images2/
#  git status
#  git pull origin-pages gh-pages
#  mv images2/*.gif images/
#  git status
  git status
  ls images
#  mkdir images2
#  cp images/* images2/
  find images2 -type f -name '*.gif' | xargs -0 -I {} echo {} | cut -d '/' -f 2 > foo
  git clean -fd images/ .bundle/ .emacs.d/ .gnupg/
  git checkout gh-pages
  git pull origin-pages gh-pages
  ls images/
  git status
  cat foo | xargs -I {} git rm images/{}
  git status
  mkdir -p images/
  git mv images2/* images/
  git mv ttyrecords/* images/
  emacs index.org --batch -f org-html-export-to-html --kill
  #  git add .
  git add index.html images/*
  git status
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"

  REALGIT=`which git`
  RETRIES=3
  DELAY=10
  COUNT=1
  while [ $COUNT -lt $RETRIES ]; do
    git pull --rebase origin-pages gh-pages
    git push --set-upstream origin-pages gh-pages
    if [ $? -eq 0 ]; then
        RETRIES=0
        break
    fi
    let COUNT=$COUNT+1
    sleep $DELAY
  done
}

setup_git
upload_files

