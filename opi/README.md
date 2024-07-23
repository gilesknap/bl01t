OPI Files
=========

In this repository there are two opi folders:

- services/opi - This folder is used as the runtime opi location mounted by
  all iocs. Its contents are not committed in to git.

  Each ioc mounts a subfolder in this directory and places its generated
  opi files in there.

  In future this will be a docker/podman volume.
  But at present there is an bug with podman that does not allow it to
  mount a subfolder of a volume. See
  [podman issue 20661](https://github.com/containers/podman/issues/20661)

- opi - This folder is a place for hand coded bob files that are copied into
  the opi volume by the init container [init.yaml](../include/init.yaml).

  The contents of this folder are committed in to git. For this reason it is
  found in .gitignore.
