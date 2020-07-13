#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]; then
  echo "Wrong number of parameters!"
  echo "Usage: $0 <poky_branch> <workspace_dir>"
  return 1
fi

poky_branch=${1}

# Create workspace directory
workspace_dir=${2}
mkdir -p "${workspace_dir}/sources" && cd "${workspace_dir}" || exit

# Clone the basic sources to build an image
if [ ! -d "sources/poky" ]; then
  git clone -b "${poky_branch}" git://git.yoctoproject.org/poky.git sources/poky
fi
if [ ! -d "sources/meta-openembedded" ]; then
  git clone -b "${poky_branch}" https://github.com/openembedded/meta-openembedded.git sources/meta-openembedded
fi
