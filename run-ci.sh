#!/bin/bash
rm images/$1.ttyrecord
mkdir images/
FOO=$1 HOME=`mktemp -d` ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "images/$1.ttyrecord"
./bin/seq2gif -w 80 -h 24 -i images/$1.ttyrecord -o images/$1.gif
echo "done"
