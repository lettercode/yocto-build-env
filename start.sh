#!/usr/bin/env bash

if [ "$(id -u)" == "0" ]; then
  echo "!You should NOT run this script as root!"
  exit 1
fi

SCRIPT=$(realpath "${0}")
SCRIPT_PATH=$(dirname "${SCRIPT}")

# Build the container
"${SCRIPT_PATH}"/docker/build.sh

# Create the same user (UID,GID) used in the actual host session
uid=$(id -u)
username="build"
gid=8888
groupname="build"
home_dir="/home/${username}"
empty_password_hash="U6aMy0wojraho"
work_directory="/buildenv"
do_login="groupadd -g ${gid} ${groupname}"
do_login+=" && useradd --password ${empty_password_hash} --shell /bin/bash --uid ${uid} --gid ${gid} --no-create-home --home-dir ${home_dir} ${username}"
do_login+=" && usermod -aG sudo ${username}"
do_login+=" && usermod -aG users ${username}"
do_login+=" && cd ${work_directory} && su ${username}"

# Mount host paths we want in the container
mounts=()
mounts+=("--mount" "type=bind,source=${SCRIPT_PATH}/home,target=${home_dir}")
mounts+=("--mount" "type=bind,source=$(pwd),target=${work_directory}")

# Start the containerized environment
docker container run -it --rm --name yocto-build-env "${mounts[@]}" lettercode/yocto-build-env:1.0 sudo bash -c "${do_login}"
