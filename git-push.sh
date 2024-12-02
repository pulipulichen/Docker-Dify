#!/bin/bash

echo "================================================================"
echo "https://ppt.cc/f5oYkx"
echo "================================================================"

cd $(dirname "$1")

git add .
git commit -m "`date`"
git push
