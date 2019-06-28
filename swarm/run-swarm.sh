#!/usr/bin/env bash

cd swarm
SWARM_EXISTS=$(docker info | grep -i 'swarm: active')

if [ -z "$SWARM_EXISTS" ]; then
    docker swarm init --advertise-addr 127.0.0.1
fi

docker stack deploy -c docker-compose.yaml syte