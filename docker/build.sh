#!/usr/bin/env bash

SCRIPT=$(realpath "${0}")
SCRIPT_PATH=$(dirname "${SCRIPT}")

docker build --tag lettercode/yocto-build-env:1.0 "${SCRIPT_PATH}"
