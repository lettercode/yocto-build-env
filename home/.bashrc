#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hlaF --color=auto --time-style long-iso --group-directories-first'
PS1="\[\033[1;34m\]\$(pwd)\[\033[0m\] > "

function init-env() {
  # Define workspace directory
  local workspace_dir
  workspace_dir="workspace"
  workspace_dir_abs=$(realpath "${workspace_dir}")
  if [ -n "${1}" ]; then
    workspace_dir=${1}
  fi

  ~/init_workspace.sh "${workspace_dir}"

  if ! cd "${workspace_dir}"; then
    echo "Failed to change into: $(pwd)/sources"
    return 1
  fi

  # Define build directory
  local build_dir
  build_dir="build"
  build_dir_abs=$(realpath "${build_dir}")
  if [ -n "${2}" ]; then
    build_dir=${2}
  fi

  . sources/poky/oe-init-build-env "${build_dir}"

  ~/init_config.sh "${workspace_dir_abs}" "${build_dir_abs}"
}

echo "***********************************************"
echo "* Welcome into the Yocto Building Environment *"
echo "***********************************************"
echo "This container aims to simplify the creation of embedded projects by providing"
echo "a containerized environment.To begin you should start by issuing:"
echo "init-env workspace build"
