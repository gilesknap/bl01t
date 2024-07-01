# beamline bl01t IOC Instances and Services

This repository holds the a definition of beamline bl01t IOC Instances and services. It is a example of how to deploy epics-containers IOCs using docker compose for those facilities that are not using Kubernetes. It also serves as a local test environment for a set of IOCs.

 The top level compose.yml file represents a set of IOCs that would be deployed to a single IOC server.

 For this example we have a single compose file. However, if you wanted to keep all IOCs for a beamline in a single repo but deploy to multiple servers, then each server would have its own named compose file.

## deploying IOCs

### Initial Setup
At DLS, first enable `docker compose`:
```bash
# this command must be run every time you want to use compose in a new shell
module load docker-compose

# the remaining commands need only be run once

# these steps will make cli completion work for zsh
mkdir -p ~/.oh-my-zsh/completions
podman completion zsh > ~/.oh-my-zsh/completions/_podman

# these steps will make cli completion work for bash
mkdir -p ~/.local/share/bash-completion/completions
podman completion bash > ~/.local/share/bash-completion/completions/podman
```

### Local Developer Environment
To launch a development environment on a workstation, including phoebus:
```bash
alias ec='podman compose' # just for convenience
export COMPOSE_PROFILES=develop UIDGID=0:0 EPICS_CA_ADDR_LIST=127.0.0.1
ec up --detach
```
(UIDGID should be 0:0 for `podman` or your user id/gid for `docker`)

### Deploy To Beamline Servers
To deploy IOCs to a server, clone this repo and run the following command from the repo root:

```bash
podman compose --profile deploy up --detach
```

or for a multiple server repo:
```bash
podman compose --profile deploy -f my_server_01.yml up --detach
```


## compose goals

These goals for switching to compose have all been met:

- be as DRY as possible
- work with docker-compose controlling either docker or podman
- enable isolated testing where PVs are not availble to the whole subnet
- include separate profiles for:
  - local testing - including phoebus OPI
  - deployment to a beamline server - this would need either:
    - network host on the IOCs
    - a ca-gateway
- structure so that there is a compose file per server
- remove need for custom code/scripts to deploy/manage the IOCs
- also allow PV isolation on servers with a ca-gateway to enable access
