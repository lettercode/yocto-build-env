#!/usr/bin/env bash

SCRIPT=$(realpath "${0}")
SCRIPT_PATH=$(dirname "${SCRIPT}")

source "${SCRIPT_PATH}/metadata.sh"

docker build --tag "${MAINTAINER}/${IMAGE}:${VERSION}" \
--build-arg "gid=${GROUP_ID}" \
--build-arg "uid=${USER_ID}" \
--build-arg "username=${USERNAME}" \
--build-arg "workdir=${WORKDIR}" \
"${SCRIPT_PATH}"
