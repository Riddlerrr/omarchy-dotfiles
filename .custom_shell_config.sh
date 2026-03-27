# OS detector
if [[ $(uname) == "Darwin" ]]; then
    export OS="macos"
elif [[ -d "$HOME/.local/share/omarchy" ]]; then
    export OS="omarchy"
elif command -v apt > /dev/null; then
    export OS="linux"
elif command -v nixos-rebuild > /dev/null; then
    export OS="nixos"
else
    echo 'Unknown OS!'
fi

alias os='echo $OS'

# Rails
alias be='bundle exec'
alias rdm="bin/rails db:migrate"
alias rdr="bin/rails db:rollback"
alias rgm="bin/rails generate migration"
alias rdtp="bin/rails db:test:prepare"
alias rrg="bin/rails routes | grep"

# Git
alias gs='git status --short'
alias gd='git diff'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'
alias gp='git pull'
alias ga='git add'
alias gb='git branch'
alias gbd='git branch -D'
alias gsl='git stash list'
alias gnb='git checkout -b'
alias gm='git checkout master'
# Beautiful git branch list
alias gba="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) | %(authorname) | (%(color:green)%(committerdate:relative)%(color:reset)) | %(if:equals=[gone])%(upstream:track)%(then)%(color:red)merged%(color:reset)%(else)%(color:cyan)open%(color:reset)%(end) | %(contents:subject)' | column -t -s '|'"
alias gprune='git fetch -p --quiet'
# Show all merged branches (deleted on the server)
alias gmerged='gprune && git for-each-ref --format="%(refname:short) %(upstream:track)" refs/heads/ | awk "\$2 == \"[gone]\" {print \$1}"'
# Delete all local branches that were merged
alias gdmerged="gmerged | xargs -r git branch -D"

load_local_aliases() {
  local alias_files=()

	if [[ -f "$HOME/.aliases.sh" ]]; then
    alias_files+=("$HOME/.aliases.sh")
  fi

	local current_dir="$PWD"
	while [[ "$current_dir" != "/" ]]; do
		if [[ -f "$current_dir/.aliases.sh" ]]; then
			alias_files=("$current_dir/.aliases.sh" "${alias_files[@]}")
		fi
		current_dir="$(dirname "$current_dir")"
	done

	for file in "${alias_files[@]}"; do
    source "$file"
  done
}

# ZSH hook to load local aliases on directory change
if [[ -n "$ZSH_VERSION" ]]; then
  autoload -U add-zsh-hook
  add-zsh-hook chpwd load_local_aliases
fi

load_local_aliases

lg() {
  if [ "$1" = "recent" ]; then
    local state_file="$HOME/.local/state/lazygit/state.yml"

    # Check if state file exists
    if [ -f "$state_file" ]; then
        # Extract the first recent repo
        local recent_repo=$(grep -A 1 "recentrepos:" "$state_file" | tail -1 | sed 's/^[[:space:]]*-[[:space:]]*//')

        # If we found a repo path, use it
        if [ -n "$recent_repo" ] && [ -d "$recent_repo" ]; then
            lazygit -p "$recent_repo"
        else
            echo "No recent repo found or directory doesn't exist"
            lazygit
        fi
    else
      echo "Warning: State file not found"
      lazygit "$@"
    fi
    else
      lazygit "$@"
    fi
}
