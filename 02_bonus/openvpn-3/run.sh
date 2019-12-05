#!/bin/sh

IP_ADDR=$(ipconfig getifaddr en0)
CLIENTNAME="tde-roqu"

docker run -v $PWD/vpn-data:/etc/openvpn --rm myownvpn ovpn_genconfig -u udp://$IP_ADDR:3000

docker run -v $PWD/vpn-data:/etc/openvpn --rm -it myownvpn ovpn_initpki

docker run -v $PWD/vpn-data:/etc/openvpn -d -p 3000:1194/udp --cap-add=NET_ADMIN myownvpn

docker run -v $PWD/vpn-data:/etc/openvpn --rm -it myownvpn easyrsa build-client-full $CLIENTNAME nopass
docker run -v $PWD/vpn-data:/etc/openvpn --rm myownvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn