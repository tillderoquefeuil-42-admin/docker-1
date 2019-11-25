#!/bin/sh

GRN="\x1B[0;32m"
YEL="\x1B[1;33m"
RST="\x1B[0m"

echo $YEL"Docker-1 | 01_dockerfiles | ex02"$RST

echo $YEL"\n\nRAILS APP CONTAINER IMAGE"$RST
echo "      docker build -t ft-rails:on-build -f ft-rails/Dockerfile .\n"

echo $YEL"Build image (y) or skip (enter)?"$RST
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
    docker build -t ft-rails:on-build -f ft-rails/Dockerfile .
    echo $GRN"\nImage successfully built"$RST

fi
RESPONSE="n"


echo $YEL"\n\nAPP IMAGE"$RST
echo "      docker build -t app .\n"

echo $YEL"Build image (y) or skip (enter)?"$RST
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
    docker build -t app .
    echo $GRN"\nImage successfully built"$RST
fi
RESPONSE="n"


echo $YEL"\n\nAPP RUNNING"$RST
echo "      docker run -d --name app -it --rm -p 3000:3000 app\n"

echo $YEL"Run the app (y) or skip (enter)?"$RST
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
    docker run -d --name app -it --rm -p 3000:3000 app

    echo "."
    sleep 1
    echo "."
    sleep 1
    echo "."
    sleep 1

    echo $GRN"\n\nThe app is now running on http://$(docker-machine ip Char):3000"$RST
    echo $GRN"To stop it, run :"$RST
    echo "      docker stop app"
fi