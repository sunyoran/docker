#!/bin/bash
brctl addbr br0
ip link set br0 up
ip addr add 192.168.5.200/24 dev br0
ip addr del 192.168.5.200/24 dev em1
brctl addif br0 em1
ip route del default
ip route add default via 192.168.5.1 dev br0


docker network create --driver=bridge --subnet=192.168.5.0/24 --gateway=192.168.5.200 -o "com.docker.network.bridge.name=br0" --aux-address "DefaultGatewayIPv4=192.168.5.1" br0

docker run -itd --name=jim --network=br0 --ip=192.168.5.202 --privileged=true sunsolve/ntest /bin/bash
