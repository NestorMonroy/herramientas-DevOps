#!/bin/bash

# docker stop $(docker ps -qa)
docker compose stop
docker system prune --all
docker volume prune
