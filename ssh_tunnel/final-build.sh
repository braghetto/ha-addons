#!/bin/bash

docker run --rm --privileged -v ~/.docker:/root/.docker -v ~/Code/ha-addons/ssh_tunnel:/data homeassistant/amd64-builder --target /data --all
