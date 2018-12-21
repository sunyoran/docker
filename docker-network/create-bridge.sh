#!/bin/bash
docker network create --driver=bridge --subnet=192.168.6.0/24 --gateway=192.168.6.50 -o "com.docker.network.bridge.name=br0" --aux-address "DefaultGatewayIPv4=192.168.6.1" br0

