
# -------------------------------
# Homebrew Setup
# -------------------------------
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # Initialize Homebrew environment on macOS
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add Homebrew to PATH
export PATH="/opt/homebrew:$PATH"

# -------------------------------
# Zinit Plugin Manager Setup
# -------------------------------
# Set the directory for Zinit and its plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install Zinit if it's not already installed
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source Zinit to load it
source "${ZINIT_HOME}/zinit.zsh"

# -------------------------------
# Zsh Plugins
# -------------------------------
# Syntax highlighting, completions, and autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Useful OMZ snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::docker
zinit snippet OMZP::python
zinit snippet OMZP::brew
zinit snippet OMZP::golang
zinit snippet OMZP::command-not-found

# Initialize zsh completion system
autoload -Uz compinit && compinit

# Improve plugin load time
zinit cdreplay -q

# -------------------------------
# Prompt Configuration
# -------------------------------
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  # Use Starship prompt if not in Apple's terminal
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
  eval "$(starship init zsh)"
fi

# -------------------------------
# Keybindings
# -------------------------------
bindkey -e                           # Emacs mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# -------------------------------
# History Configuration
# -------------------------------
HISTSIZE=5000                        # Number of history entries
HISTFILE=~/.zsh_history              # File to store command history
SAVEHIST=$HISTSIZE
HISTDUP=erase                        # Erase duplicates
setopt appendhistory                 # Append to history file
setopt sharehistory                  # Share history across sessions
setopt hist_ignore_space             # Ignore commands that start with space
setopt hist_ignore_all_dups          # Ignore duplicates in history
setopt hist_save_no_dups             # Save without duplicates
setopt hist_ignore_dups              # Remove duplicate entries from history
setopt hist_find_no_dups             # Prevent searching duplicates in history

# -------------------------------
# Completion Styling
# -------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -------------------------------
# k9s
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# -------------------------------
# Aliases
# -------------------------------
#alias cat='bat'                      # Use bat for syntax-highlighted cat
alias ls="eza --icons=always"        # Use eza for better ls
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
alias vim='vim'
alias c='clear'
alias z='zoxide'                     # Faster directory navigation
alias y='yazi'
alias zshconfig="vim ~/.zshrc"
alias hostfile="sudo vim /etc/hosts"
alias sshconfig="vim ~/.ssh/config"
alias k='kubectl'
alias n='nerdctl'
alias kns='kubens'
alias kctx='kubectx'
alias t='tofu'
alias brewup="brew update; brew upgrade; brew cleanup; brew doctor;"
alias z4j='zellij'
alias p6r='bunx prettier . --write'
alias renovate='renovate --platform=local'
alias rgrep='rg'

# -------------------------------
# Git & GitHub Setup
# -------------------------------
alias g='git'
alias gcm='git commit -m' # Git commit with message
alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse' # Create a new GitHub repo
alias gh-pull='gh pr create --base main --head $(git rev-parse --abbrev-ref HEAD) --title "PR: $(git rev-parse --abbrev-ref HEAD)"' # Create a new PR
alias gh-push='gh repo sync && git push origin $(git rev-parse --abbrev-ref HEAD)' # Push current branch to GitHub

# -------------------------------
# Docker and Podman Setup
# -------------------------------
export PODMAN_COMPOSE_PROVIDER=podman-compose
alias docker='podman'

# ---------------------------------
# JavaScript and Node.js Setup
# --------------------------------
export PATH="$HOME/.bun/bin:$PATH"   # Bun package manager

# -------------------------------
# Shell Integrations and Completions
# -------------------------------
eval "$(fzf --zsh)"                  # FZF fuzzy finder
eval "$(zoxide init --cmd cd zsh)"   # Zoxide initialization
eval "$(thefuck --alias)"            # TheFuck command fixer
source <(kubectl completion zsh)     # Kubectl completions
eval "$(atuin init zsh)"             # Atuin history manager

# -------------------------------
# Go Programming Language Setup
# -------------------------------
# 1. Optional: override GOPATH (defaults to $HOME/go)
export GOPATH="$HOME/go"                             # Go workspace

# 2. Don’t set GOROOT; let Go detect it
# export GOROOT="$(brew --prefix go)/libexec"       # Not needed

# 3. PATH updates
export PATH="$(brew --prefix go)/libexec/bin:$PATH"  # Homebrew’s Go toolchain
export PATH="$GOPATH/bin:$PATH"                      # Go workspace binaries

# 4. (Optional) New Go 1.24+ environment variables
# export GOAUTH="…"                                    # Private module auth
# export GOFIPS140="…"                                # FIPS 140-3 module version
# export GODEBUG="…"                                  # Toolchain runtime tweaks

# Golang Aliases
alias gob="go build"       # Build the current package
alias got="go test ./..."  # Run all tests
alias goc="go clean"       # Clean up compiled files
alias gor="go run ."       # Run the current Go package
alias gof="go fmt ./..."   # Format Go code in the current directory
alias gov="go version"     # Print Go version
alias goi="go install"     # Install the current package

# -------------------------------
# Python Setup (Pyenv and Pipenv)
# -------------------------------
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"               # Initialize Pyenv

# If you want pyenv and pipenv to automatically select the right environment
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# Python Aliases
alias pipfile="pipenv install"      # Install from Pipenv's Pipfile
alias pyclean="find . -name '__pycache__' -delete"  # Clean Python caches
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# Rustup
export PATH="$HOME/.cargo/bin:$PATH"

# -------------------------------
# Bun Setup
# -------------------------------
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
