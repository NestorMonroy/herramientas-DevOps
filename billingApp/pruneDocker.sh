#!/bin/bash

docker stop $(docker ps -qa)
docker system prune --all
docker volume prune
