#!/bin/bash
#
### Mac OS X configuration

config_macosx () {
  ## Set Computer and Hostnames
  logn "Checking HostName:"
  if [[ $(scutil --get HostName) != "${REMDOT_COM_NAME}" ]]; then
    logn "Setting Computer and Hostnames to ${REMDOT_COM_NAME}..."
    sudo scutil --set ComputerName "${REMDOT_COM_NAME}"
    sudo scutil --set LocalHostName "${REMDOT_COM_NAME}"
    sudo scutil --set HostName "${REMDOT_COM_NAME}"
    dscacheutil -flushcache
  fi
  logk

  ## Finder defaults

  # show hidden files
  log "Adjusting Finder settings..."
  logn "Show hidden files:"
  if [[ $(defaults read com.apple.finder AppleShowAllFiles) != "TRUE" ]]; then
  defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder; fi
  logk

  logn "Enable copy to clipboard from Quick Look view:"
  if [[ $(defaults read com.apple.finder QLEnableTextSelection) != "TRUE" ]]
  then
    defaults write com.apple.finder QLEnableTextSelection -bool TRUE &&\
    killall Finder
  fi
  logk
  #
  ## Keyboard
  # defaults write com.apple.keyboard.fnState -int 1

  log "Screensaver settings..."
  logn "Enabling OS X screensaver password immediately for better security:"
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
  logk

  logn "Adding contact message to login screen:"
  if [[ -n "$REMDOT_GIT_NAME" ]] && [[ -n "$REMDOT_ICLOUD_EMAIL" ]]; then
  sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText \
  "Found this computer? Please contact $REMDOT_GIT_NAME at $REMDOT_ICLOUD_EMAIL."
  fi
  logk

  logn "Disabling \"Application Downloaded from Internet\" quarantine warning:"
  defaults write com.apple.LaunchServices LSQuarantine -bool NO
  logk

  logn "Setting ScreenCapture folder to ${HOME}/Pictures/screenshots:"
  local SCREENCAP="${HOME}/Pictures/screencaps"
  mkdir -p "${SCREENCAP}" && \
  defaults write com.apple.screencapture location "${SCREENCAP}"
  killall SystemUIServer
  logk

  logn "Checking for Pictures shortcut on Desktop:"
  if [[ ! -L "${HOME}/Desktop/Pictures" ]]; then
    logn "Adding Pictures shortcut to Desktop:"
    ln -s "${HOME}/Pictures" "${HOME}/Desktop/Pictures"
  fi
  logk
}

config_macosx

