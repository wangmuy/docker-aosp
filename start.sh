#!/bin/sh
mydir="$( cd `dirname $0` && pwd )"
[ -n "$WORKDIR_ROOT" ] && cd $WORKDIR_ROOT
[ -f $mydir/start_private.sh ] && source $mydir/start_private.sh
[ -f $mydir/start-user.sh ] && startScript=$mydir/start-user.sh
exec sudo -E -u aosp $startScript $*
