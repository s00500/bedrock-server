#!/bin/sh

docker build --build-arg ARCH=amd64 --platform linux/amd64 -t s00500/bedrock:latest .
docker push s00500/bedrock:latest

