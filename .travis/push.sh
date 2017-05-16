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
  mkdir images2
  cp images/*.gif images2/
  export images=$(find images2 -type f -name '*.gif' | xargs -0 -I {} echo {} | cut -d '/' -f 2)
  rm -rf images/
  git checkout gh-pages
  git pull
  ls images/
  git status
  echo $images | xargs -0 -I {} git rm images/{}
  git status
#  emacs index.org --batch -f org-html-export-to-html --kill
#  git add index.html images/*.gif
#  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
#  git push --set-upstream origin-pages gh-pages
}

setup_git
echo "setup git"
upload_files
echo "git push"
echo "done"
