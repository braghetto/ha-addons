#!/bin/bash

docker run --rm --privileged -v ~/.docker:/root/.docker -v ~/Code/ha-addons/ripe_atlas_probe:/data homeassistant/amd64-builder --target /data --all
