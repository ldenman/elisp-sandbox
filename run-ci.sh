#!/bin/bash
set -e
NAME_1=$(echo $1 |cut -f 1 -d '.')
NAME=`echo $NAME_1-$EMACS_VERSION | tr . -`
if [[ -n $TRAVIS_BUILD_DIR ]]; then
TERM=xterm-256color TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR ELFILE=$1 HOME=$TRAVIS_BUILD_DIR ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "$TRAVIS_BUILD_DIR/images/$NAME.ttyrecord"
./bin/seq2gif -w 80 -h 24 -i $TRAVIS_BUILD_DIR/images/$NAME.ttyrecord -o $TRAVIS_BUILD_DIR/images/images/$NAME.gif
else
TERM=xterm-256color ELFILE=$1 HOME=`mktemp -d` ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "images/$NAME.ttyrecord"
seq2gif -w 80 -h 24 -i images/$NAME.ttyrecord -o images/$NAME.gif
fi
echo "done"
