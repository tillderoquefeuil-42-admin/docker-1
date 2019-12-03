#!/bin/sh

RED="\x1B[1;31m"
GRN="\x1B[1;32m"
YEL="\x1B[0;33m"
RST="\x1B[0m"

echo $YEL"Building a simple debian container\n\n"$RST
docker build -t debian .

echo $YEL"\n\nRunning the container"$RST
echo $YEL"\nInside the container, run:"$RST
echo "service openvpn start"
echo $YEL"Now you can check logs in OpenVPN Admin Panel\n"$RST

docker run -it --privileged debian