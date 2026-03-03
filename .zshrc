# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load zsh options, keybindings, and completion
[[ -f /usr/share/omarchy-zsh/shell/zoptions ]] && source /usr/share/omarchy-zsh/shell/zoptions

# Load shared shell configuration (aliases, functions, environment, tool init)
[[ -f /usr/share/omarchy-zsh/shell/all ]] && source /usr/share/omarchy-zsh/shell/all

# Add your own customizations below

# load plugins, must be installed as a package first
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey -e # emacs mode (vim mode is disabled)

# Completions setup
autoload -Uz compinit
compinit
fpath=(/usr/share/zsh/site-functions $fpath)

# completion improvements
zstyle ':completion:*' menu select  # Навигация стрелками в меню
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Игнорировать регистр
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Цвета как в ls
zstyle ':completion:*' rehash true  # Автоматически находить новые команды

# Custom confings
source ~/.custom_shell_config.sh

# Autostart scripts
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_rsa 2>/dev/null
fi

# Custom common keybindings
bindkey '^[[A' history-substring-search-up # Up arrow (default up-line-or-search)
bindkey '^[[B' history-substring-search-down # Down arrow (default down-line-or-search)
bindkey '^[[H' beginning-of-line # Home
bindkey '^[[F' end-of-line # End
bindkey '^[[3~' delete-char # Delete
bindkey '^?' backward-delete-char # Backspace

# Save and restore the last used dir
LASTDIR_FILE="$HOME/.cache/zsh/last-directory"
[[ -d "$HOME/.cache/zsh" ]] || mkdir -p "$HOME/.cache/zsh"

if [[ -f "$LASTDIR_FILE" ]] && [[ -d "$(cat "$LASTDIR_FILE")" ]]; then
    cd "$(cat "$LASTDIR_FILE")"
fi

chpwd() {
    pwd > "$LASTDIR_FILE"
}
