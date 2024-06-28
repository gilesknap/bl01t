# beamline bl01t IOC Instances and Services

This repository holds the a definition of beamline bl01t IOC Instances and services. Each sub folder of the `services` directory contains a helm chart for a specific service or IOC.

NOTE: in order to take advantage of version control, you must deploy these services using the edge-containers-cli. This will ensure that the services are deployed from a specific tag of this repository and that the version number is recorded in the cluster.

See https://github.com/epics-containers/edge-containers-cli for more information.

## updating to docker compose

This is an experimental 'beamline' that is demonstrating use of compose
to replace our home grown `ec` deployment tool and make the configuation

- more widely understood
- far more flexible

# compose goals

- be as DRY as possible
- work with podman-compose as well as docker-compose
- enable isolated testing where PVs are not availble to the whole subnet
- include profiles for:
  - local testing - including phoebus
  - deployment to a beamline server - this would need either:
    - network host on the IOCs
    - a ca-gateway
- structure so that there is a compose file per server

# difficulties

To make this work for both podman and docker you can share the network
namespace between all IOCs and phoebus. Not a great solution.
  use `channel_access` network in bl01t-ea-test-01.
  add `network_mode: service:bl01t-ea-test-01`.
this run phoebus inside the container
  podman does not need the shared network namespace and I believe this
  is because all containers have the same IP but docker containers
  are bridged to each other via NAT.
perhaps the tidiest solution is to run phoebus inside for podman
and with host=net for docker. Again I'm not too sure why this works for docker,
but certainly docker container IPs are routable (and broadcastable) from the
host and apparently this means all ports are open to the host.
The key issue with CA is that the search response contains a random PORT
for the virtual circuit to be set up and this random port has no range
constraints I can find - thus you cannot use port openning to enable
the virtual circuit creation
see https://docs.epics-controls.org/en/latest/internal/ca_protocol.html#overall-server-operation
An additional thorn is that running X11 forwarding to inside a container
network works for both podman/docker on ubuntu but is failing on DLS workstations
with podman.
THUS I HAVE NO SOLUTION FOR DLS WORKSTATIONS.

summary of likely approaches:

- docker:
  - run phoebus with host network
- podman:
  - try to get x11 working in a container at DLS and use that
  - or use net host for IOCs like we used to but make it easy to pick
    a different EPICS_CA_SERVER_PORT
