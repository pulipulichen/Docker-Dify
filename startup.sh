#!/bin/bash

full_path=$(realpath "$0")
base_dir=$(dirname "$full_path")
cd "$base_dir"

git clean -f -d
git fetch origin
git reset --hard origin/main

cd ./Dify/docker

docker-compose down
docker-compose up --build -d > /dev/null 2>&1 &

# ===========

cd "$base_dir"
# pwd
cd ./Firecrawl/

docker-compose down
docker-compose up -d > /dev/null 2>&1

# ===========

cd "$base_dir"
# pwd
cd ./SearXNG/

# bash ./docker.sh > /dev/null 2>&1 &
docker-compose down
docker-compose up -d > /dev/null 2>&1

# ===========

sleep 5

echo $base_dir
cd "$base_dir"
# pwd
cd ./Ollama/

docker-compose down
docker-compose up -d > /dev/null 2>&1

# sleep 30

# ===========

# sleep 5

echo $base_dir
cd "$base_dir"
# pwd
cd ./DocKnowledgeBase/

docker-compose down
docker-compose up -d > /dev/null 2>&1

# ===========

# sleep 5

echo $base_dir
cd "$base_dir"
# pwd
cd ./KnowledgeBaseTable/

docker-compose down
docker-compose up -d > /dev/null 2>&1

# ===========

# sleep 5

# # https://ithelp.ithome.com.tw/m/articles/10369119

# # apt-get update
# # apt-get install -y python3-pip
# # pip3 install huggingface-hub nltk

# echo $base_dir
# cd "$base_dir"
# # pwd
# cd ./RAGFlow/

# # python3 ./download_deps.py
# # docker build -f Dockerfile -t infiniflow/ragflow:dev 

# # cd ./docker/

# # docker compose up -d > /dev/null 2>&1

# # docker compose down
# # docker compose up -d > /dev/null 2>&1

# # sleep 30

# docker compose -f docker/docker-compose.yml up -d > /dev/null 2>&1


# ===========

# sleep 5
