#!/bin/bash

cd "$(dirname "$0")"

git fetch origin
git reset --hard origin/main

docker-compose up --build