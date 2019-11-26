#!/bin/sh

GRN="\x1B[0;32m"
YEL="\x1B[1;33m"
RST="\x1B[0m"

echo $YEL"Docker-1 | 01_dockerfiles | ex00"$RST

echo $YEL"\n\nBUILD ex00"$RST
echo "      docker build -t ex00 .\n"

if [ "$1" != "-y" ]
then
    echo $YEL"Build image (y) or skip (enter)?"$RST
    read RESPONSE
else
    echo $YEL"Building image"$RST
    RESPONSE="y"
fi

if [ "$RESPONSE" = "y" ]
then
    docker build -t ex00 .
    echo $GRN"\nImage successfully built"$RST
fi
RESPONSE="n"


echo $YEL"\n\nRUN ex00"$RST
echo "      docker run -it --name ex00 --rm ex00\n"

if [ "$1" != "-y" ]
then
    echo $YEL"Run image (y) or skip (enter)?"$RST
    read RESPONSE
else
    echo $YEL"Running image"$RST
    RESPONSE="y"
fi

if [ "$RESPONSE" = "y" ]
then
    docker run -it --name ex00 --rm ex00
fi


