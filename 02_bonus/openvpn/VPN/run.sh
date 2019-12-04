#!/bin/sh

RED="\x1B[1;31m"
GRN="\x1B[1;32m"
YEL="\x1B[0;33m"
RST="\x1B[0m"

MACHINE_IP=$(docker-machine ip Char)

echo $YEL"OPENVPN WITH DOCKER\n\n"$RST

echo $YEL"Creation of the container image"$RST
docker create --name=openvpn-as \
    --restart=always \
    -v /sgoinfre/goinfre/Perso/tde-roqu/docker/openvpn-as/config:/config \
    -e INTERFACE=ens3 \
    -e PGID=1004 -e PUID=1000 \
    -e TZ=Europe/Warsaw \
    --net=host --privileged \
    linuxserver/openvpn-as

echo $YEL"\nLaunch the VPN server"$RST
docker start openvpn-as

echo $YEL"\nChange admin password"$RST
docker exec -it openvpn-as passwd admin

echo $GRN"\nYou can log here as admin (admin/new_password)"$RST
echo "https://$MACHINE_IP:943/admin"

echo $GRN"\nYou can log here as client"$RST
echo "https://$MACHINE_IP:943"

echo $GRN"\nto stop run :"$RST
echo "      docker stop openvpn-as"