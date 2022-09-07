#!/usr/bin/env bash

docker run -ti -v $PWD:/docker_in -v $PWD/dist:/docker_out --platform=linux/x86_64 humangeo/aglio -i /docker_in/api.md -o /docker_out/index.html
