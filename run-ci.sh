#!/bin/bash
NAME_1=$(echo $1 |cut -f 1 -d '.')
NAME=`echo $NAME_1-$EMACS_VERSION | tr . -`
mkdir images/
ELFILE=$1 HOME=`mktemp -d` ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "images/$NAME.ttyrecord"
./bin/seq2gif -w 80 -h 24 -i images/$NAME.ttyrecord -o images/$NAME.gif
echo "done"
