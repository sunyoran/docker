#!/bin/bash

brctl addbr br0 
ip link set br0 up
ip addr add 192.168.6.50/24 dev br0
ip addr del 192.168.6.50/24 dev ens32
brctl addif br0 ens32
ip route del default
ip route add default via 192.168.6.1 dev br0
