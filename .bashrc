# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Auto-launch zsh shell if in interactive bash
if command -v zsh &> /dev/null; then
  if [[ $(ps --no-header --pid=$PPID --format=comm) != "zsh" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
  then
    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
    exec zsh $LOGIN_OPTION
  fi
fi

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Custom confings
source ~/.custom_shell_config.sh

# Autostart scripts
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_rsa 2>/dev/null
fi
