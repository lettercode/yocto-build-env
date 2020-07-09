#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  echo "Wrong number of parameters!"
  echo "Usage: $0 <workspace_dir> <build_dir>"
  return 1
fi

workspace_dir=${1}
build_dir=${2}
cache_dir=$(realpath "${workspace_dir}/cache")

# Create cache directories
mkdir -p "${cache_dir}/downloads"
mkdir -p "${cache_dir}/sstate"

# Change the default local.conf configuration to use the predefined sstate and download directories
local_conf=${build_dir}/conf/local.conf
dl_dir="DL_DIR ?= \"${cache_dir}/downloads\""
sstate_dir="SSTATE_DIR ?= \"${cache_dir}/sstate\""

if ! grep -q "^\s*${dl_dir}\s*$" "${local_conf}"; then
  # Comment out active download dir
  sed -i 's;^\s*\(DL_DIR.*\);#\1;' "${local_conf}"

  # Add the download directory to the local.conf file
  sed -i "1s;^;${dl_dir}\n\n;" "${local_conf}"
fi
if ! grep -q "^\s*${sstate_dir}\s*$" "${local_conf}"; then
  # Comment out active sstate dir
  sed -i 's;^\s*\(SSTATE_DIR.*\);#\1;' "${local_conf}"

  # Add the sstate directory to the local.conf file
  sed -i "1s;^;${sstate_dir}\n\n;" "${local_conf}"
fi
