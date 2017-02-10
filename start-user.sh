#!/bin/bash
mydir="$( cd `dirname $0` && pwd )"
[ -f $mydir/start-user_private.sh ] && source $mydir/start-user_private.sh

# proxy
if [ $# -gt 0 ]; then
    $*
else
    /bin/bash
fi
