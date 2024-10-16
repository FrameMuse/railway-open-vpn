FROM alpine:latest

WORKDIR /usr/src/shadowsocks


ARG _ENV_PORT
ARG _ENV_PASSWORD

RUN apk add --no-cache gcc openrc musl-dev && apk add --no-cache rust cargo
RUN cargo install shadowsocks-rust

ADD https://raw.githubusercontent.com/FrameMuse/railway-open-vpn/refs/heads/main/config.example.json ./config.json

RUN sed -i "s|\[port\]|$_ENV_PORT|g" ./config.json
RUN sed -i "s|\[password\]|$_ENV_PASSWORD|g" ./config.json

EXPOSE ${_ENV_PORT}
ENTRYPOINT /root/.cargo/bin/ssserver -c ./config.json

RUN echo $_ENV_PORT
RUN echo $_ENV_PASSWORD
