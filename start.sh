#!/bin/sh
mydir="$( cd `dirname $0` && pwd )"
[ -n "$WORKDIR_ROOT" ] && cd $WORKDIR_ROOT
[ -f $mydir/start_envsetup.sh ] && . $mydir/start_envsetup.sh
[ -f $mydir/start_private.sh ] && . $mydir/start_private.sh
[ -f $mydir/start-user.sh ] && startScript=$mydir/start-user.sh
exec sudo -E -u aosp $startScript $*
