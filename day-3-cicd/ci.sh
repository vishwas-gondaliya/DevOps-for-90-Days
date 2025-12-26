#!/bin/bash

set -e

echo "running tests"
./test.sh

echo "building image"
docker build -t day3-app1 .

echo "Deploying"
docker run --rm day3-app1

echo "pipeline successful"
