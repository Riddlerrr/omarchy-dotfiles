# Keep Paperclip CLI state at the same location as its systemd service.
export PAPERCLIP_HOME="${PAPERCLIP_HOME:-/home/sergei/workspace/homelab/paperclip/state}"

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

export PI_CLIPBOARD_OSC52=1

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  return
fi

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
# /etc/omarchy.conf is written by omarchy-dev-link. When absent, force the
# package default instead of preserving a stale inherited dev-link value before
# we decide which rc file to source.
if [[ -f /etc/omarchy.conf ]]; then
  source /etc/omarchy.conf
  export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
else
  export OMARCHY_PATH=/usr/share/omarchy
fi
source "$OMARCHY_PATH/default/bash/rc"

# Custom confings
source ~/.custom_shell_config.sh

# Autostart scripts
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_rsa 2>/dev/null
fi
