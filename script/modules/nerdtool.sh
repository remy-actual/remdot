#!/bin/bash
#
## Install NertTool app
# TODO: configure Qlock dynamic desktop background

config_nerdtool () {

  local DEFAULT="${HOME}/pro/src/github.com/remy-actual/remdot/config"
  local CONFIG="${REMDOT_CONFIG_DIR:-$DEFAULT}/nerdtool"

  local APP="NerdTool"
  local PKG="nerdtool-0.8.1.zip"

  log "Beginning ${APP} setup..."

  if ls "${HOME}/Applications/${APP}"* >/dev/null; then
    log "${APP} currently installed in ${HOME}/Applications"
  elif ls "/Applications/${APP}"* >/dev/null; then
    log "${APP} currently installed in /Applications"
  else
    log "${APP} not found."
    logn "Downloading ${PKG}..."
    local URL="https://cloud.github.com/downloads/balthamos/geektool-3"
    curl -LS "${URL}/${PKG}" -o "${CONFIG}/${PKG}" && logk
    local VAL
    VAL=$(unzip "${CONFIG}/${PKG}" | grep -m1 'creating:' | cut -d' ' -f5-)
    logn "Unzipping ${PKG} to ${VAL} and deleting compressed file..."
    unzip -o "${CONFIG}/${PKG}" -d "${CONFIG}/${VAL}"\
      && rm -rf "${CONFIG:?}/${PKG}"\
      && logk
    logn "Installing ${PKG}..."
    mv "${CONFIG}/${VAL}/"*".app" "${HOME}/Applications" && logk
    logn "Cleaning up..."
    rm -rf "${CONFIG:?}/${VAL}" && logk
  fi

  log "${APP} setup complete"

}

config_nerdtool

