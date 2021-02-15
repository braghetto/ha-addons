#!/bin/bash

docker run --rm -v /tmp/atlas:/data --privileged --cap-add=SYS_ADMIN --cap-add=NET_RAW --cap-add=CHOWN --mount type=tmpfs,destination=/tmp,tmpfs-size=64M -e RXTXRPT=yes --name ripe_probe --hostname "$(hostname --fqdn)" ripe_probe:latest
