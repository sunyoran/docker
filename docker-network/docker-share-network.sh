#!/bin/bash
#
#
#	   +----------------------------------------------------------------------------------------+
#       |  +---------------------------------------------------------------------------------+   |
#       |  |  +------------------------------+           +---------------------------------+ |   |
#       |  |  |                              |           |                                 | |   |
#       |  |  |                              |           |                                 | |   |
#       |  |  |        [ network-test ]      |           |                                 | |   |
#       |  |  |        192.168.5.201         |           |      192.168.5.202              | |   |
#       |  |  |                      vEth0   |           |             vEth0               | |   |
#       |  |  +------------------------------+           +---------------------------------+ |   |
#       |  |                       |                                 |                       |   |
#       |  |                       |                                 |                       |   |
#       |  |                       |                                 |                       |   |
#       |  |                       |                                 |                       |   |
#       |  |               +-------------------------------------------------+               |   |
#       |  |               |                                                 |               |   |
#       |  |               |                Bridge 0 (br0)                   |               |   |
#       |  |               |                                                 |               |   |
#       |  +---------------------------------------------------------------------------------+   |
#       |                                           | 192.168.5.200                              |
#       |                                           |                                            |
#       |                                   Docker  |                                            |
#       |                           +---------------------------------+ iptables filter          |
#       |                                           |                                            |
#       +----------------------------------------------------------------------------------------+
#                                                   |  Eth0
#                                                   +
#

## [HOST] Setup a new network bridge
brctl addbr br0  

# [HOST] startup bridge 
ip link set br0 up

# [HOST] etup ip address to bridge using the docker host external ip address
ip addr add 192.168.6.50/24 dev br0

# [HOST] remove ip address from docker host external network interface
ip addr del 192.168.6.50/24 dev ens32

# [HOST] connect docker host external network to bridge
brctl addif br0 ens32  

# [HOST] remove old default route, set new default gateway on bridge interface
ip route del default
ip route add default via 192.168.6.1 dev br0

# [HOST] using sunsolve/ntest to create a container [network-test] for network testing
docker rm -f jim
docker run -itd --name=jim --network=none --privileged=true sunsolve/ntest /bin/bash

# [HOST] using pipework to setup container [ network-test ]
pipework br0 jim 192.168.6.51/24@192.168.6.50

# change default route in container [ network -test]
# [HOST] connect to container first
#docker exec -it jim /bin/bash
# [CONTAINER ] change default route
#ip route del default
#ip route add default via 192.168.5.50 dev vEth0


#systemctl stop firewalld
#systemctl start iptables 

#iptables-restore < /data/iptables.docker

# [ HOST ] set iptables to  allow container [ network-test ] packet be forwarded
#iptables -A FORWARD -o br0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -i br0 ! -o br0 -j ACCEPT
#iptables -A FORWARD -i br0 -o br0 -j ACCEPT

# Then you can ping outside network from container and container can be accessed from outside

