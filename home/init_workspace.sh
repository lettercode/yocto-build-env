#!/usr/bin/env bash
set -e

SCRIPT=$(realpath "${0}")
SCRIPT_PATH=$(dirname "${SCRIPT}")

if [ "$#" -ne 1 ]; then
  echo "Wrong number of parameters!"
  echo "Usage: $0 <workspace_dir>"
  return 1
fi

# Create workspace directory
workspace_dir=${1}
mkdir -p "${workspace_dir}/sources" && cd "${workspace_dir}" || exit

poky_branch="dunfell"

# Clone the basic sources to build an image
if [ ! -d "sources/poky" ]; then
  git clone -b ${poky_branch} git://git.yoctoproject.org/poky.git sources/poky
fi
if [ ! -d "sources/meta-openembedded" ]; then
  git clone -b ${poky_branch} https://github.com/openembedded/meta-openembedded.git sources/meta-openembedded
fi

# Add custom layers
if [ -f "${HOME}/extra_layers.sh" ]; then
  BRANCH=${poky_branch} "${SCRIPT_PATH}/extra_layers.sh"
fi
