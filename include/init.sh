#!/bin/sh

# The init service shell script - initialises the opi volumes with any custom
# bob files from this repo and ensures that each IOC has a subfolder in the
# volumes.

# copy in any opi files from the repo
cp -r /repo/opi/* /opi;
