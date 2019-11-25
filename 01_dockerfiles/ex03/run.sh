#!/bin/sh

GRN="\x1B[0;32m"
YEL="\x1B[1;33m"
RST="\x1B[0m"

echo $YEL"Docker-1 | 01_dockerfiles | ex03"$RST

echo $YEL"\n\nBUILD wdtfs"$RST
echo "      docker build --build-arg VM_IP=$(docker-machine ip Char) -t wdtfs .\n"

echo $YEL"Build image (y) or skip (enter)?"$RST
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
    docker build --build-arg VM_IP=$(docker-machine ip Char) -t wdtfs .
    echo $GRN"\nImage successfully built"$RST
fi
RESPONSE="n"


echo $YEL"\n\nRUN wdtfs"$RST
echo "      docker run -it -p 8080:80 -p 8022:22 -p 8443:443 --privileged wdtfs\n"

echo $YEL"Run image (y) or skip (enter)?"$RST
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
    echo $GRN"\n\nLETS GO!."$RST
    docker run -it -p 8080:80 -p 8022:22 -p 8443:443 --privileged wdtfs
fi
