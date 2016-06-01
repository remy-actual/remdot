#!/bin/bash
#
## Seil
# Map CapsLock to Escape key

defaults write org.pqrs.Seil.plist isCheckUpdate -int 1
defaults write org.pqrs.Seil.plist kResumeAtLogin -int 1

# Map ESC to CAPS LOCK key
defaults write org.pqrs.Seil.plist \
  sysctl '{ "enable_capslock" = 1;
            "keycode_capslock" = 53; }';

