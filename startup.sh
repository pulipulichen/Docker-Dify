#!/bin/bash

cd "$(dirname "$0")"

git clean -f -d
git fetch origin
git reset --hard origin/main

cd ./Dify/docker

docker-compose up --build