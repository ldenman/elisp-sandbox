#!/bin/bash
HOME=`mktemp -d` emacs -nw  --eval "(progn (load-file \"common.el\")(load-file \"$1\")(load-file \"package-demo/package-demo.el\")(load-file \"$1.demo\")(kill-emacs 0))"
