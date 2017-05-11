#!/bin/bash
HOME=`mktemp -d` emacs -Q -l common.el -l $1 
