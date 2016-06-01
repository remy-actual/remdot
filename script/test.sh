#!/bin/bash
#
log()   { REMDOT_STEP="$*"; echo "--> $*"; }
logn()  { REMDOT_STEP="$*"; printf -- "--> $* "; }
logk()  { REMDOT_STEP="";   echo "OK"; }
### Mac OS X configuration

config_macosx () {
  logn "Setting ScreenCapture folder to ${HOME}/Pictures/screenshots:"
  local SCREENCAP="${HOME}/Pictures/screencaps"
  mkdir -p "${SCREENCAP}" && \
  defaults write com.apple.screencapture location "${SCREENCAP}"
  killall SystemUIServer
  logk

  logn "Adding Pictures shortcut to Desktop:"
  ln -s "${HOME}/Pictures" "${HOME}/Desktop/Pictures"
  logk
}

config_macosx

