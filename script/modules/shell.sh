#!/bin/bash
#

config_shell () {

  local DEFAULT="${HOME}/pro/src/github.com/remy-actual/remdot/config"
  local CONFIG="${REMDOT_CONFIG_DIR:-$DEFAULT}/shell"

  log "Beginning shell setup..."

  ## bash
  log "Checking for bashrc in \$HOME:"
  if [[ -e ${HOME}/.bashrc ]]; then
    logk
  else
    logn "Symlinking bashrc:"
    ln -s "${REMDOT_CONFIG_DIR}/bash/.bashrc" "${HOME}/.bashrc" && logk
  fi

  ## zsh
  logn "Checking for homebrew zsh in /etc/shells:"
  if grep -aq "$(which zsh)" "/etc/shells"; then logk; else
    log "Homebrew Zsh not found."
    logn "Adding:"
    printf "%s\n" "$(which zsh)" | sudo tee -a /etc/shells && logk
  fi

   # Use prezto fork for zsh configuration framework
  log "Checking for Prezto:"
  if [[ -d ${CONFIG}/zsh/.zprezto ]]; then
    logk
  else
    log "Local Zprezto not found."
    logn "Cloning from Github..."
    git clone --recursive \
      "https://github.com/${REMDOT_GITHUB_USER:-"sorin-ionescu"}/prezto.git" \
      "${CONFIG}/zsh/.zprezto" && logk
  fi

  log "Checking for Prezto in \$HOME:"
  if [[ -L ${HOME}/.zprezto ]]; then
    logk
  else
    log "Prezto not found in \$HOME."
    logn "Symlinking..."
    ln -s "${CONFIG}/zsh/.zprezto" "${HOME}/.zprezto" && logk
  fi

  log "Checking for Zsh runcoms in \$HOME:"
  if [[ ! -L ${HOME}/.zshrc ]]; then
    log "Zsh runcoms not found."
    logn "Symlinking..."
    for zfile in ${CONFIG}/zsh/.zprezto/runcoms/z*; do
    ln -s "$zfile" "${HOME}/.$(basename "$zfile")"; done
  fi
    logk

   # Get current shell
  [[ "${OSTYPE}" == darwin* ]] \
    && uSHELL=$(dscl . -read "${HOME}" UserShell \
     | tr "[:space:]" "\n" \
     | tail -1 \
     )
   # Get current shell
  logn "Checking current shell:"
  echo "${uSHELL}"
  [[ $(which zsh) == "${uSHELL}" ]] \
    || {
         logn changing default user shell to Zsh:
         sudo chsh -s "$(which zsh)" && logk
       }

  log "Shell setup complete!"

}

config_shell

