#!/bin/bash
NAME=`echo $1-$EMACS_VERSION | tr . -`
mkdir images/
HOME=`mktemp -d` ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "images/$1.ttyrecord"
./bin/seq2gif -w 80 -h 24 -i images/$1.ttyrecord -o images/$NAME.gif
echo "done"
