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

# Create a site.conf file for sstate and download directories
cat <<EOF >"${build_dir}/conf/site.conf"
# Default configuration for sstate and download dirs
# ==================================================
DL_DIR ?= "${cache_dir}/downloads"
SSTATE_DIR ?= "${cache_dir}/sstate"

# Free the space used in tmp/work
# to retain some packages use
# RM_WORK_EXCLUDE += "your-package"
# =================================
INHERIT += "rm_work"
RM_OLD_IMAGE = "1"
EOF

# Add user customizations
if [ -f "${HOME}/extra_config.sh" ]; then
  cat <<EOF >>"${build_dir}/conf/site.conf"

# Customizations from extra_config.sh
# ===================================
EOF
  cat "${HOME}/extra_config.sh" >>"${build_dir}/conf/site.conf"
fi
