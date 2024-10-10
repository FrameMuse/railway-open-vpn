#!/bin/bash

sudo /usr/local/bin/ssserver -c /etc/shadowsocks/ss.json --user nobody -qq -d start
