#!/bin/sh
mydir="$( cd `dirname $0` && pwd )"
type sudo > /dev/null 2>&1 || apt-get update && apt-get install -y sudo
id aosp > /dev/null 2>&1 || DOCKER_ENVSETUP=true . $mydir/docker_entrypoint.sh
