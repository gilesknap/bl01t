# beamline bl01t IOC Instances and Services

This repository holds the a definition of beamline bl01t IOC Instances and services. It is a example of how to deploy epics-containers IOCs using docker compose for those facilities that are not using Kubernetes. It also serves as a local test environment for a set of IOCs.

 The top level compose.yml file represents a set of IOCs that would be deployed to a single IOC server.

 For this example we have a single compose file. However, if you wanted to keep all IOCs for a beamline in a single repo but deploy to multiple servers, then each server would have its own named compose file.

## deploying IOCs

To deploy IOCs to a server, clone this repo and run the following command from the repo root:

```bash
docker-compose --profile deploy up --detach
```

or for a multiple server repo:
```bash
docker-compose --profile deploy -f my_server_01.yml up --detach
```

To launch a development environment on a workstation, including phoebus:
```bash
UIDGID=0:0 COMPOSE_PROFILE=develop docker-compose up
```
(UIDGID should be 0:0 for podman and your user id/gid for docker)

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
