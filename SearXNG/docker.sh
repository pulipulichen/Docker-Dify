#!/bin/bash

cd "$(dirname "$0")"

docker run --rm -p 40001:8080 -v "./searxng:/etc/searxng" searxng/searxng:2024.12.1-0245e82bd &