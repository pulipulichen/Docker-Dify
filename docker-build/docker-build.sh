#!/bin/bash

docker-compose build

APP_NAME=docker-clip-crawler-app
TAG_NAME=pudding/github-action-app:puppeteer-python-14-docker-clip-crawler-20240121-0415

docker tag "$APP_NAME" "$TAG_NAME"
docker push "$TAG_NAME"