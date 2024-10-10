FROM alpine:edge

WORKDIR /usr/src/vpn

ARG PORT
ARG PASSWORD


RUN apk update
RUN apk add openrc --no-cache

RUN wget --no-check-certificate -O shadowsocks.sh https://raw.githubusercontent.com/Vndroid/shadowsocks-install/master/shadowsocks.sh
RUN chmod +x shadowsocks.sh
RUN ./shadowsocks.sh install 2>&1 | tee shadowsocks.log

ADD https://raw.githubusercontent.com/FrameMuse/railway-open-vpn/refs/heads/main/start.sh ./start.sh
ADD https://raw.githubusercontent.com/FrameMuse/railway-open-vpn/refs/heads/main/config.example.json /etc/shadowsocks-libev/config.json

RUN sed -i "s|[port]|$VPN_PORT|g" /etc/shadowsocks-libev/config.json
RUN sed -i "s|[password]|$ARG VPN_PASSWORD|g" /etc/shadowsocks-libev/config.json

RUN rc-update add shadowsocks-libev default
RUN rc-service shadowsocks-libev start
