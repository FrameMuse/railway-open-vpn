FROM alpine:3.20.0

WORKDIR /usr/src/vpn

ARG VPN_PORT
ARG VPN_PASSWORD

RUN apt update
RUN apt install shadowsocks-libev

ADD https://raw.githubusercontent.com/FrameMuse/railway-open-vpn/refs/heads/main/config.example.json /etc/shadowsocks-libev/config.json

RUN sed -i "s|[port]|$VPN_PORT|g" /etc/shadowsocks-libev/config.json
RUN sed -i "s|[password]|$ARG VPN_PASSWORD|g" /etc/shadowsocks-libev/config.json

RUN sudo systemctl restart shadowsocks-libev
RUN sudo systemctl status shadowsocks-libev
