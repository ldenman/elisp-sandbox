#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  mv images/ images-bak/
}

upload_files() {
  git remote add origin-pages https://${GH_TOKEN}@github.com/ldenman/elisp-sandbox.git > /dev/null 2>&1
  git fetch origin-pages
  git checkout --track origin-pages/gh-pages gh-pages
  mv images-bak images
  emacs index.org --batch -f org-html-export-to-html --kill
  git add index.html images/*.gif
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
  git push --set-upstream origin-pages gh-pages
}

setup_git
echo "setup git"
commit_website_files
echo "commit web files"
upload_files
echo "git push"
echo "done"
