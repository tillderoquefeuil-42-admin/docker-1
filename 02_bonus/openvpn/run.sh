#!/bin/sh

RED="\x1B[1;31m"
GRN="\x1B[1;32m"
YEL="\x1B[0;33m"
RST="\x1B[0m"

IP_ADDR=$(ipconfig getifaddr en0)
VPN_USER="tde-roqu"
OVPN_DATA="ovpn-data-volume"

echo $YEL""$RST
echo $GRN""$RST

echo $YEL"OPENVPN WITH DOCKER\n\n"$RST

echo $YEL"Creation of the data volume container"$RST
docker volume create --name $OVPN_DATA

echo $YEL"Generation the config file"$RST
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://$IP_ADDR

echo $YEL"Initialization of the PKI"$RST
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki

echo $YEL"Launch the VPN server"$RST
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

echo $YEL"Creation of the user"$RST
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full $VPN_USER nopass

echo $YEL"Generation of user's config file"$RST
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient $VPN_USER > $VPN_USER.ovpn


echo $GRN"\n\nYour VPN is ready to go!"$RST