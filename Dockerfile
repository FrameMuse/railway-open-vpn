FROM alpine:latest

WORKDIR /usr/src/shadowsocks

ARG PORT
ARG PASSWORD

RUN apk add --no-cache gcc openrc musl-dev && apk add --no-cache rust cargo
RUN cargo install shadowsocks-rust

ADD https://raw.githubusercontent.com/FrameMuse/railway-open-vpn/refs/heads/main/config.example.json ./config.json

RUN sed -i "s|\[port\]|$PORT|g" ./config.json
RUN sed -i "s|\[password\]|$PASSWORD|g" ./config.json

EXPOSE $PORT
ENTRYPOINT /root/.cargo/bin/ssserver -c ./config.json
