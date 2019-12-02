FROM debian

ENV CLIENTNAME=tde-roqu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openvpn

COPY users-config/$CLIENTNAME.ovpn /opt/ovpn
WORKDIR /opt/ovpn

# RUN install -o root -m 400 CLIENTNAME.ovpn /etc/openvpn/CLIENTNAME.conf

ENTRYPOINT bash