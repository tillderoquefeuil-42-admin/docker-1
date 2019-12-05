#!/bin/sh

OVPN_DATA="ovpn-data"
IP_ADDR=$(ipconfig getifaddr en0)
CLIENTNAME="tde-roqu"

docker run --name $OVPN_DATA -v /etc/openvpn busybox
docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u udp://vpn.$IP_ADDR:1194

docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn ovpn_initpki

docker run --volumes-from ovpn-data --rm -p 1194:1194/udp --cap-add=NET_ADMIN --privileged kylemanna/openvpn

docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass
docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn