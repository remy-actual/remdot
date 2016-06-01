#!/bin/bash
#
## Vim

config_vim () {

  local DEFAULT="${HOME}/pro/src/github.com/remy-actual/remdot/config"
  local CONFIG="${REMDOT_CONFIG_DIR:-$DEFAULT}/vim"

  log "Beginning vim setup..."

  log "Checking for vimrc  in \$HOME:"
  if [[ -e ${HOME}/.vimrc ]]; then
    logk
  else
    log "Vim runcom not found."
    logn "Symlinking..."
    ln -s "${CONFIG}/.vimrc" "${HOME}/.vimrc" && logk
  fi

  log "Checking for vim config directory in \$HOME:"
  if [[ -d ${HOME}/.vim ]]; then
    logk
  else
    log "Vim directory not found."
    logn "Symlinking..."
    ln -s "${CONFIG}/.vim" "${HOME}/.vim" && logk
  fi

  log "Installing Vim plugings with Vundle:"
  vim +PluginInstall +qall && logk

  log "Vim setup complete!"

}

config_vim

