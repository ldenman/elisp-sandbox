#!/bin/bash
NAME_1=$(echo $1 |cut -f 1 -d '.')
NAME=`echo $NAME_1-$EMACS_VERSION | tr . -`
if [[ -n $TRAVIS_BUILD_DIR ]]; then
mkdir -p $TRAVIS_BUILD_DIR/images
mkdir -p $TRAVIS_BUILD_DIR/images2
mkdir -p $TRAVIS_BUILD_DIR/ttyrecords
HOME=$TRAVIS_BUILD_DIR emacs --batch --eval "(load-file \"preloader.el\")"
TERM=xterm-256color TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR ELFILE=$1 HOME=$TRAVIS_BUILD_DIR ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "$TRAVIS_BUILD_DIR/ttyrecords/$NAME.ttyrecord"
./bin/seq2gif -w 80 -h 24 -i $TRAVIS_BUILD_DIR/ttyrecords/$NAME.ttyrecord -o $TRAVIS_BUILD_DIR/images2/$NAME.gif
else
emacs_home=`mktemp -d`
HOME=$emacs_home emacs --batch --eval "(load-file \"preloader.el\")"
TERM=xterm-256color ELFILE=$1 HOME=$emacs_home ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "images/$NAME.ttyrecord"
seq2gif -w 80 -h 24 -i images/$NAME.ttyrecord -o images/$NAME.gif
fi
echo "done"
