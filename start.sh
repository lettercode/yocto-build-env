#!/usr/bin/env bash

set -e

if [ "$(id -u)" == "0" ]; then
  echo "!You should NOT run this script as root!"
  exit 1
fi

SCRIPT=$(realpath "${0}")
SCRIPT_PATH=$(dirname "${SCRIPT}")

# Build the container
uid=$(id -u)
gid=$(id -g)
USER_ID=$uid GROUP_ID=$gid "${SCRIPT_PATH}"/docker/build.sh

# Create an user with the same UID used in the actual host session
source "${SCRIPT_PATH}/docker/metadata.sh"
home_dir="/home/${USERNAME}"

# Mount host paths we want in the container
mounts=()
mounts+=("--mount" "type=bind,source=${SCRIPT_PATH}/home,target=${home_dir}")
mounts+=("--mount" "type=bind,source=${SCRIPT_PATH}/buildenv,target=${WORKDIR}")

# provide (empty) folder buildenv
mkdir -p buildenv

# Start the containerized environment
docker container run -it --init --rm --name "${IMAGE}" "${mounts[@]}" "${MAINTAINER}/${IMAGE}:${VERSION}"
