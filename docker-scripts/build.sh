#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

# make sure the working directory contains the neccessary files
[ -f "$PWD/Dockerfile" ] || die "Dockerfile not found in '$PWD'!"
[ -d "$PWD/src" ] || die "src directory not found in '$PWD'!"

DIR=$PWD

cd src
npm ci && ./dist.sh || die "creating dist files failed!"

cd $DIR
docker build . -t wog:latest
