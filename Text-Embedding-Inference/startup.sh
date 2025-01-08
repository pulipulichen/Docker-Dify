#!/bin/bash

model=BAAI/bge-reranker-large
volume=$PWD/data # share a volume with the Docker container to avoid downloading weights every run

docker run -p 38086:80 -v $volume:/data --pull always ghcr.io/huggingface/text-embeddings-inference:cpu-1.6 --model-id $model &