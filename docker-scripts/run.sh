#!/bin/bash

DATA=$(realpath .)/data

docker run \
  --mount type=bind,source=$DATA,target=/app/storage \
  --mount type=bind,source=/var/log,target=/var/log_host \
  -p 8080:8082 \
  --net=host \
  --name wog \
  -d wog:latest
