#!/bin/bash
HOME=`mktemp -d` emacs --batch --eval "(load-file \"common.el\")(load-file \"$1\")(save-buffers-kill-terminal))"
