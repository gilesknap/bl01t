#!/bin/sh

# The init service shell script - initialises the opi volume with any custom
# bob files from this repo and ensures that each IOC has a subfolder in the
# volume.

# copy in any opi files from the repo
cp -r /repo/opi/* /opi;

# make sure there is a subfolder of opi volume for each service
cd /repo/services
for i in *; do
  echo adding folder $i to opi volume
  mkdir -p /opi/$i;
done