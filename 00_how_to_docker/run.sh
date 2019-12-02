#!/bin/sh

YEL="\x1B[1;33m"
RED="\x1B[1;31m"
RST="\x1B[0m"

echo $YEL"Command :"$RST
cat $1
echo $YEL"\n\nOutput :"$RST
./$1

if [ $1 = '03' ]; then
    echo $RED"\nWatch out!\nThis command can't be run like this!\nYou have to run 'eval \$(docker-machine env Char)' in your terminal\nTo see if it works, run 'docker-machine ls'"$RST
fi