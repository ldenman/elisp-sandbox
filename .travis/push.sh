#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  mkdir images-bak
  mv images/* images-bak/
}

upload_files() {

#  git fetch origin-pages
  git add images/
  git stash
  git checkout gh-pages
  git stash apply
  emacs index.org --batch -f org-html-export-to-html --kill
  git add index.html images/*.gif
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
  git remote add origin-pages https://${GH_TOKEN}@github.com/ldenman/elisp-sandbox.git > /dev/null 2>&1
  git push --set-upstream origin-pages gh-pages
}

setup_git
echo "setup git"
commit_website_files
echo "commit web files"
upload_files
echo "git push"
echo "done"
