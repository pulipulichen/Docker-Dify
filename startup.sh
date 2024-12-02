#!/bin/bash

cd "$(dirname "$0")"

git clean -f -d
git fetch origin
git reset --hard origin/main

cd ./Dify/docker

docker-compose up --build -d > /dev/null 2>&1 &

cd ./../Ollama/

docker-compose up -d > /dev/null 2>&1 &
