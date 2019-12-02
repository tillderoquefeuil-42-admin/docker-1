#!/bin/sh

RED="\x1B[1;31m"
GRN="\x1B[1;32m"
YEL="\x1B[0;33m"
RST="\x1B[0m"

IP_ADDR=$(docker-machine ip Char)
VPN_USER="tde-roqu"
OVPN_DATA="ovpn-data-volume"

echo $YEL"OPENVPN WITH DOCKER\n\n"$RST

docker pull kylemanna/openvpn

docker run --name ovpn-data -v /etc/openvpn busybox

docker run --volumes-from ovpn-data --rm kylemanna/openvpn ovpn_genconfig -u udp://vpn.$IP_ADDR

docker run --volumes-from ovpn-data --rm -it kylemanna/openvpn ovpn_initpki

docker run --volumes-from ovpn-data -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
docker run --volumes-from ovpn-data --rm -it kylemanna/openvpn easyrsa build-client-full client-bureau nopass
docker run --volumes-from ovpn-data --rm kylemanna/openvpn ovpn_getclient client-bureau > client-bureau.ovpn

echo $GRN"\n\nYour VPN is ready to go!"$RST