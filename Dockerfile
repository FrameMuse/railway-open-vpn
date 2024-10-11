FROM alpine:edge

WORKDIR /usr/src/vpn

ARG PORT
ARG PASSWORD


RUN apk update
RUN apk add rust cargo
RUN apk add openrc

RUN cargo install shadowsocks shadowsocks-rust

# ADD https://raw.githubusercontent.com/FrameMuse/railway-open-vpn/refs/heads/main/start.sh ./start.sh
ADD https://raw.githubusercontent.com/FrameMuse/railway-open-vpn/refs/heads/main/config.example.json ./config.json

RUN sed -i "s|[port]|$PORT|g" ./config.json
RUN sed -i "s|[password]|$PASSWORD|g" ./config.json

RUN ssserver -c ./config.json
