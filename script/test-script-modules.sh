#!/bin/bash
#
# script/setup: Set up RemDot for the first time after cloning, or set it
#               back to the initial first unused state.

set -e

# Keep sudo timestamp updated while Remdot is running.
if [ "$1" = "--sudo-wait" ]; then
  while true; do
    mkdir -p "/var/db/sudo/${SUDO_USER}"
    touch "/var/db/sudo/${SUDO_USER}"
    sleep 1
  done
  exit 0
fi

[ "$1" = "--debug" ] && REMDOT_DEBUG="1"
REMDOT_SUCCESS=""

cleanup() {
  set +e
  if [ -n "${REMDOT_SUDO_WAIT_PID}" ]; then
    sudo kill "${REMDOT_SUDO_WAIT_PID}"
  fi
  sudo -k
  rm -f "${CLT_PLACEHOLDER}"
  if [ -z "${REMDOT_SUCCESS}" ]; then
    if [ -n "${REMDOT_STEP}" ]; then
      echo "!!! ${REMDOT_STEP} FAILED" >&2
    else
      echo "!!! FAILED" >&2
    fi
    if [ -z "${REMDOT_DEBUG}" ]; then
      echo "!!! Run '$0 --debug' for debugging output." >&2
      echo "!!! If you're stuck: file an issue with debugging output at:" >&2
      echo "!!!   ${REMDOT_ISSUES_URL}" >&2
    fi
  fi
}

trap "cleanup" EXIT

if [ -n "${REMDOT_DEBUG}" ]; then
  set -x
else
  REMDOT_QUIET_FLAG="-q"
  Q="${REMDOT_QUIET_FLAG}"
fi

STDIN_FILE_DESCRIPTOR="0"
[ -t "${STDIN_FILE_DESCRIPTOR}" ] && REMDOT_INTERACTIVE="1"

## File paths ##

# Get executable as called
SOURCE="${BASH_SOURCE[0]}"

# Check for and resolve symlink executable calls to physical file location
check_sym () {
  local SRC="${SOURCE}"
  # While $SRC is a symlink, resolve it
  while [ -L "${SRC}" ]; do
    local DIR
    DIR="$( cd -P "$( dirname "${SRC}" )" && pwd )"
    SRC="$( readlink "${SRC}" )"
    # If $SRC was a relative symlink (so no "/" as prefix,
    # need to resolve it relative to the symlink base directory
    [[ ${SRC} != /* ]] && SRC="${DIR}/${SRC}"
  done
  echo "${SRC}"
}
REMDOT_SYM_SRC=$(check_sym)

# Get physical script command, path and absolute path to project root
REMDOT_RES_CMD="$(basename "${REMDOT_SYM_SRC}")"
REMDOT_RES_DIR="$(cd -P "$(dirname "${REMDOT_SYM_SRC}")" && pwd)"
REMDOT_RES_FULL="${REMDOT_RES_DIR}/${REMDOT_RES_CMD}"
export REMDOT_RES_FULL
REMDOT_PROJ_ROOT=$(cd "${REMDOT_RES_DIR}/.."; pwd)
REMDOT_CONFIG_DIR="${REMDOT_PROJ_ROOT}/config"
export REMDOT_CONFIG_DIR

# Get executable absolute command name and path
REMDOT_EXE_CMD="$( basename "${SOURCE}" )"
REMDOT_EXE_DIR="$( cd "$( dirname "${SOURCE}" )" && pwd )"
REMDOT_EXE_FULL="${REMDOT_EXE_DIR}/${REMDOT_EXE_CMD}"

abort() { REMDOT_STEP="";   echo "!!! $*" >&2; exit 1; }
log()   { REMDOT_STEP="$*"; echo "--> $*"; }
logn()  { REMDOT_STEP="$*"; printf -- "--> $* "; }
logk()  { REMDOT_STEP="";   echo "OK"; }

# Check compatible OS X Version
sw_vers -productVersion | grep $Q -E "^10.(9|10|11|12)" || {
  abort "Run Remdot on Mac OS X 10.9/10/11/12."
}

# Prohibit running as root
[ "${USER}" = "root" ] && abort "Run Remdot as yourself, not root."
# Prohibit running as non-admin
groups | grep $Q admin || abort "Add ${USER} to the admin group."

# Initialise sudo now to save prompting later.
log "Enter your password (for sudo access):"
sudo -k
sudo /usr/bin/true
[ -f "${REMDOT_EXE_FULL}" ]
sudo bash "${REMDOT_EXE_FULL}" --sudo-wait &
REMDOT_SUDO_WAIT_PID="$!"
ps -p "${REMDOT_SUDO_WAIT_PID}" &>/dev/null
logk

# Get local credentials
log "Obtaining user credentials..."
if [[ -r "${HOME}/.credentials" ]]; then
  logn "Reading from local file:"
  # shellcheck source=/dev/null
  . "${HOME}/.credentials"
  logk
else
# [TODO]: read user input if no credentials
  abort "\$HOME/.credentials missing or unreadable"
fi

# Setup Git configuration.
logn "Configuring Git:"
if [ -n "${REMDOT_GIT_NAME}" ] \
&& [[ ! -n $(git config --get --global user.name) ]]
then
  git config --global user.name "${REMDOT_GIT_NAME}"
fi

if [ -n "${REMDOT_GIT_EMAIL}" ] \
&& [[ ! -n $(git config --get --global user.email) ]]
then
  git config --global user.email "${REMDOT_GIT_EMAIL}"
fi

if [ -n "${REMDOT_GITHUB_USER}" ] \
&& [[ ! -n $(git config --get --global github.user) ]]
then
  git config --global github.user "${REMDOT_GITHUB_USER}"
fi

# Squelch git 2.x warning message when pushing
if ! git config push.default >/dev/null; then
  git config --global push.default simple
fi

# Setup GitHub HTTPS credentials.
if [ -n "${REMDOT_GITHUB_USER}" ] && [ -n "${REMDOT_GITHUB_TOKEN}" ] \
  && git credential-osxkeychain 2>&1 | grep $Q "git.credential-osxkeychain"
then
  if [ "$(git config credential.helper)" != "osxkeychain" ]
  then
    git config --global credential.helper osxkeychain
  fi
  printf "protocol=https\nhost=github.com\n" | git credential-osxkeychain erase
  printf "protocol=https\nhost=github.com\nusername=%s\npassword=%s\n" \
        "${REMDOT_GITHUB_USER}" "${REMDOT_GITHUB_TOKEN}" \
        | git credential-osxkeychain store
fi
logk

# Run script modules
for script_module in ${REMDOT_RES_DIR}/modules/*; do
#   shellcheck source=/dev/null
    source "${script_module}"
  done

REMDOT_SUCCESS="1"
log "Remdot setup successful"

