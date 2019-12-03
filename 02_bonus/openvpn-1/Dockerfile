FROM debian

ENV VPN_USER="tde-roqu"


RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openvpn curl

COPY tde-roqu.ovpn /
RUN install -o root -m 400 $VPN_USER.ovpn /etc/openvpn/$VPN_USER.conf
RUN echo AUTOSTART=all | tee -a /etc/default/openvpn
RUN /etc/init.d/openvpn restart

ENTRYPOINT bash