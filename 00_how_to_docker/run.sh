#!/bin/sh

YEL="\x1B[1;33m"
RST="\x1B[0m"

echo $YEL"Command :"$RST
cat $1
echo $YEL"\n\nOutput :"$RST
./$1