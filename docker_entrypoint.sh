#!/bin/bash
set -e

# This script designed to be used a docker ENTRYPOINT "workaround" missing docker
# feature discussed in docker/docker#7198, allow to have executable in the docker
# container manipulating files in the shared volume owned by the USER_ID:GROUP_ID.
#
# It creates a user named `aosp` with selected USER_ID and GROUP_ID (or
# 1000 if not specified).

# Example:
#
#  docker run -ti -e USER_ID=$(id -u) -e GROUP_ID=$(id -g) imagename bash
#

# Reasonable defaults if no USER_ID/GROUP_ID environment variables are set.
if [ -z ${USER_ID+x} ]; then USER_ID=1000; fi
if [ -z ${GROUP_ID+x} ]; then GROUP_ID=1000; fi

msg="docker_entrypoint: Creating user UID/GID [$USER_ID/$GROUP_ID]" && echo $msg
groupadd -g $GROUP_ID -r aosp && \
useradd -u $USER_ID --create-home -r -g aosp aosp
echo "$msg - done"

msg="docker_entrypoint: Copying .gitconfig and .ssh/config to new user home" && echo $msg
[ -f /root/.gitconfig ] && cp /root/.gitconfig /home/aosp/.gitconfig && \
chown aosp:aosp /home/aosp/.gitconfig
mkdir -p /home/aosp/.ssh
[ -f /root/.ssh/config ] && cp /root/.ssh/config /home/aosp/.ssh/config
chown aosp:aosp -R /home/aosp/.ssh && \
echo "$msg - done"

msg="docker_entrypoint: Creating /tmp/ccache and /aosp directory" && echo $msg
if [ ! -d /tmp/ccache ]; then
    mkdir -p /tmp/ccache /aosp
    chown aosp:aosp /tmp/ccache /aosp
    echo "$msg - done"
fi

echo "aosp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "entrypoint script done!"

if [ -z "$DOCKER_ENVSETUP" ]; then
  echo "entrypoint going exec..."
  # Default to 'bash' if no arguments are provided
  args="$@"
  if [ -z "$args" ]; then
    args="bash"
  fi
  exec $args
fi

