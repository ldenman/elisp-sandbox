#!/bin/bash
rm images/*
mkdir images/
FOO=$1 HOME=`mktemp -d` ttyrec -e 'emacs --debug-init -nw --eval "(load-file \"loader.el\"))"' "images/$1.ttyrecord"
./bin/seq2gif -w 100 -h 60 -i images/$1.ttyrecord -o images/$1.gif
echo "done"
