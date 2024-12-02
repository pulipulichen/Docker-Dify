#!/bin/bash

cd "$(dirname "$0")"

model=Alibaba-NLP/gte-multilingual-reranker-base
volume=$PWD/data # share a volume with the Docker container to avoid downloading weights every run

docker run --gpus all -p 8080:80 -v $volume:/data --pull always ghcr.io/huggingface/text-embeddings-inference:1.5 --model-id $model