#!/bin/bash
export HOME=/home/aosp
mydir="$( cd `dirname $0` && pwd )"
[ -n "$WORKDIR_USER" ] && cd $WORKDIR_USER
[ -f $mydir/start-user_private.sh ] && source $mydir/start-user_private.sh

# proxy
if [ $# -gt 0 ]; then
    $*
else
    /bin/bash
fi
