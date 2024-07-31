#! /bin/bash

# Setup environment variables required to launch the services described in this
# repo. A standard install of docker compose and permission to run docker
# are the only other requirements (membership of the docker group).
#
# docker compose may be backed by podman or docker container engines, see
# https://epics-containers.github.io/main/tutorials/setup_workstation.html.


# This script must be sourced
if [ "$0" = "$BASH_SOURCE" ]; then
    echo "ERROR: Please source this script (source environment.sh)"
    exit 1
fi

function check_docker {
    # return 0 if docker is detected, or 1 otherwise,
    # cope with the possibility that podman is aliased to docker
    if [[ $(docker version) =~ "Podman"  ]]&> /dev/null; then
        return 1
    fi
}

if check_docker; then
    USER_ID=$(id -u); USER_GID=$(id -g)
else
    USER_ID=0; USER_GID=0
fi

# Set up the environment for compose ###########################################

# set user id for the phoebus container for easy X11 forwarding.
export UIDGID=$USER_ID:$USER_GID
# choose develop profile for docker compose
export COMPOSE_PROFILES=develop
# for develop profile our ca-gateway publishes PVS on the loopback interface
export EPICS_CA_ADDR_LIST=127.0.0.1
# make a short alias for docker-compose for convenience
alias ec='docker compose'