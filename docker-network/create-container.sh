#!/bin/bash
docker run -itd --name=jim --network=br0 --ip=192.168.6.51 --privileged=true sunsolve/ntest /bin/bash
