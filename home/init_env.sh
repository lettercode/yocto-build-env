POKY_BRANCH="dunfell"
WORKSPACE_DIR="workspace"
BUILD_DIR="build"

# Define workspace directory
WORKSPACE_DIR=$(realpath "${WORKSPACE_DIR}")
if [ -n "${1}" ]; then
  WORKSPACE_DIR=$(realpath "${1}")
fi

~/init_workspace.sh "${POKY_BRANCH}" "${WORKSPACE_DIR}"

if ! cd "${WORKSPACE_DIR}"; then
  echo "Failed to change into: ${WORKSPACE_DIR}"
  return 1
fi

# Define build directory
BUILD_DIR=$(realpath "${BUILD_DIR}")
if [ -n "${2}" ]; then
  BUILD_DIR=$(realpath "${2}")
fi

source sources/poky/oe-init-build-env "${BUILD_DIR}"

~/init_config.sh "${WORKSPACE_DIR}" "${BUILD_DIR}"

# Add custom layers
if [ -f "${HOME}/extra_layers.sh" ]; then
  BRANCH="${POKY_BRANCH}" SOURCES="${WORKSPACE_DIR}/sources" ~/extra_layers.sh
fi
