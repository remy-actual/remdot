#!/bin/bash
#

config_iTerm2 () {

  local DEFAULT="${HOME}/pro/src/github.com/remy-actual/remdot/config"
  local CONFIG="${REMDOT_CONFIG_DIR:-$DEFAULT}/iterm2"

  # Install monospace Font for Powerline 
  log "Configuring iTerm2..."
  logn "Checking for Powerline font..."
  [[ -r "${HOME}/Library/Fonts/Inconsolata-dz for Powerline.otf" ]]\
    || brew bundle --file=- <<-EOF
      cask 'font-inconsolata-dz-for-powerline'
	EOF
  logk

  logn "Load settings from plist file in Remdot repository..."
  defaults write com.googlecode.iterm2 \
    LoadPrefsFromCustomFolder \
    -bool TRUE

  defaults write com.googlecode.iterm2 \
    PrefsCustomFolder \
    -string "${CONFIG}"
  logk

  logn "Set app to save config changes on exit..."
  if [[ $(defaults read com.googlecode.iterm2 \
                        NoSyncNeverRemindPrefsChangesLostForFile_selection) != 0 ]]
  then
    defaults write com.googlecode.iterm2 \
      NoSyncNeverRemindPrefsChangesLostForFile \
      -bool TRUE
    defaults write com.googlecode.iterm2 \
      NoSyncNeverRemindPrefsChangesLostForFile_selection \
      -bool FALSE
  fi
  logk

}

config_iTerm2

