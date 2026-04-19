export SECOND_BRAIN="$HOME/vaults/personal"
export MODERNCV="$HOME/projects/latex/moderncv"
export GITUSER="jihillestad"
export REPOS="$HOME/repos"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export EDITOR="/opt/homebrew/bin/nvim"

# Initialize Starship
eval "$(starship init zsh)"

# Plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Node NVM Path
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh" # This loads nvm
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search docker docker-compose kubectl terraform)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"


# Aliases overriding standard tools with modern ones
alias vim=nvim
alias v=nvim
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias cat=bat
alias t=tmux
alias ta="tmux a -t "
alias tn="tmux new -s "
alias tkill="tmux kill-server"

# Aliases for applications
alias skim='open /Applications/Skim.app/'
alias word='open /Applications/Microsoft\ Word.app'
alias excel='open /Applications/Microsoft\ Excel.app'
alias chrome='open /Applications/Google\ Chrome.app'
alias cn="chrome -n"

# Navigation
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0-inbox/"
alias ..="cd .."
alias ....="cd ../../"
alias ......="cd ../../../"

# Git
alias gc="git commit -m "
alias gca="git commit -a -m "
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Dockerized Azure CLI
# alias exparm="export ARM_ACCESS_KEY=$(docker exec azure-cli sh -c 'cat /tmp/ARM_ACCESS_KEY.txt')"

# Dockerized Terraform
# alias dtfinit="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest init"
# alias dtfinitrc="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest init -reconfigure"
# alias dtfplan="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest plan -out main.tfplan"
# alias dtfapply="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest apply main.tfplan"
# alias dtfdestroy="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest destroy"
# alias dtfrefresh="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest refresh"
#
# FZF Aerospace search

ff() {
  aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}
# ricing

alias alday='sed -i "" "s/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyo-night\.toml\"\]/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyonight_day\.toml\"\]/" $DOTFILES/alacritty.toml'
alias alnight='sed -i "" "s/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyonight_day\.toml\"\]/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyo-night\.toml\"\]/" $DOTFILES/alacritty.toml'
alias termnight="$DOTFILES/scripts/termnight.sh"
alias termday="$DOTFILES/scripts/termday.sh"
alias eb='v ~/.bashrc'
alias ez='v ~/.zshrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias szr='source ~/.zshrc'

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v "$(fp)"'

#  ---- FZF ----

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"


### Fix for making Docker plugin work
autoload -U compinit && compinit
###

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
