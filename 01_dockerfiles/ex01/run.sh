#!/bin/sh

GRN="\x1B[0;32m"
YEL="\x1B[1;33m"
RST="\x1B[0m"

echo $YEL"Docker-1 | 01_dockerfiles | ex01"$RST

echo $YEL"\n\nBUILD ex01"$RST
echo "      docker build -t ex01 .\n"

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
    docker build -t ex01 .
    echo $GRN"\nImage successfully built"$RST
fi
RESPONSE="n"


echo $YEL"\n\nRUN ex01"$RST
echo "      docker run -d --name teamspeak --rm -p 9987:9987/udp -p 10011:10011 -p 30033:30033 ex01\n"

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
    docker run -d --name teamspeak --rm -p 9987:9987/udp -p 10011:10011 -p 30033:30033 ex01

    echo "."
    sleep 1
    echo "."
    sleep 1
    echo "."
    sleep 1

    echo $GRN"\n\nex01 is now running."$RST
    echo $GRN"connect with local client to $(docker-machine ip Char)"$RST
    echo $GRN"to stop run :"$RST
    echo "      docker stop teamspeak"
fi


