FROM debian

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openvpn

COPY client-bureau.ovpn /root/

ENTRYPOINT bash