#!/bin/bash
#
## NodeJS
# Use N to install and manage versions

logn "Checking for \"N\" NodeJS version manager:"
if type -p n >/dev/null; then
  logk
else
  brew install n && logk
fi

log "NodeJs editions:"
logn "Verifying/Installing latest dev release..."
n latest && logk 
logn "Verifying/Installing current LTS edition..."
n lts && logk
logn "Verifying/Installing latest stable release..."
n stable && logk

log "NodeJS setup complete"

