#!/bin/sh

RED="\x1B[1;31m"
GRN="\x1B[1;32m"
YEL="\x1B[0;33m"
RST="\x1B[0m"

IP_ADDR=$(docker-machine ip Char)
VPN_USER="tde-roqu"
OVPN_DATA="ovpn-data-volume"

echo $YEL"OPENVPN WITH DOCKER\n\n"$RST

git clone https://github.com/kylemanna/docker-openvpn.git
cd docker-openvpn

docker build -t myownvpn .
cd ..
mkdir vpn-data

docker run -v $PWD/vpn-data:/etc/openvpn --rm myownvpn ovpn_genconfig -u udp://$IP_ADDR:3000

docker run -v $PWD/vpn-data:/etc/openvpn --rm -it myownvpn ovpn_initpki


docker run -v $PWD/vpn-data:/etc/openvpn -d -p 3000:1194/udp --cap-add=NET_ADMIN myownvpn

docker run -v $PWD/vpn-data:/etc/openvpn --rm -it myownvpn easyrsa build-client-full user1 nopass


echo $GRN"\n\nYour VPN is ready to go!"$RST