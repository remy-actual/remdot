# Make changes in .bashrc immediately available
bashrc-reload() { builtin exec bash ; }

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi
