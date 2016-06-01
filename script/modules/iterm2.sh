#!/bin/bash
#
## iTerm2

# Install monospace Font for Powerline 
[[ -r "${HOME}/Library/Fonts/Inconsolata-dz for Powerline.otf" ]]\
  || brew bundle --file=- <<EOF
    cask 'font-inconsolata-dz-for-powerline'
EOF

# Load config from directory; set path to plist file. 
defaults write com.googlecode.iterm2 \
  LoadPrefsFromCustomFolder \
  -int 1

defaults write com.googlecode.iterm2 \
  PrefsCustomFolder \
  -string "${REMDOT_CONFIG_DIR}/iterm2"

