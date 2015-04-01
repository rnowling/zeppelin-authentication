#!/bin/sh
 
# From https://gist.github.com/xaviervia/6adea3ddba269cadb794

env

# Preprend the upstream configuration
sed -i s/ZEPPELIN_SERVER/${ZEPPELIN_PORT_8080_TCP_ADDR}/g /etc/nginx/nginx.conf 

# log result
cat /etc/nginx/nginx.conf
 
# Start nginx
nginx
