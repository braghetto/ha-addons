#!/bin/bash

docker build --build-arg BUILD_FROM="homeassistant/amd64-base-debian:latest" -t ripe_probe .
