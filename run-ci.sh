#!/bin/bash
NAME_1=$(echo $1 |cut -f 1 -d '.')
NAME=`echo $NAME_1-$EMACS_VERSION | tr . -`
mkdir images/
TERM=xterm-256color TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR ELFILE=$1 HOME=$TRAVIS_BUILD_DIR ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "images/$NAME.ttyrecord"
./bin/seq2gif -w 120 -h 40 -i images/$NAME.ttyrecord -o images/$NAME.gif
echo "done"
