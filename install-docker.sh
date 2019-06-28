#!/bin/bash -e

DOCKER_VERSION="18.09"
DOCKER_SCRIPT_URL="https://releases.rancher.com/install-docker/$DOCKER_VERSION.sh"

curl -LJ --progress-bar $DOCKER_SCRIPT_URL | sh