#!/bin/bash

cd "$(dirname "$0")"

git pull
git reset --hard HEAD

docker-compose up --build