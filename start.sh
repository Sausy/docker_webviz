#!/usr/bin/env bash

docker stop webviz
docker rm webviz

docker-compose up -d webviz
