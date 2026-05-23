# NVIM is my editor
alias vim=nvim
alias v=nvim

# EZA
alias l="eza --icons --git"
alias ls="eza --icons --git"
alias ll="eza -lg --icons --git"
alias la="eza -lag --icons --git"
alias lt="eza -lTg --icons --git"
alias lt1="eza -lTg --level=1 --icons --git"
alias lt2="eza -lTg --level=2 --icons --git"
alias lt3="eza -lTg --level=3 --icons --git"
alias lta1="eza -lTag --level=1 --icons --git"
alias lta2="eza -lTag --level=2 --icons --git"
alias lta3="eza -lTag --level=3 --icons --git"
alias cat=bat
alias t=tmux
alias ta="tmux a -t "
alias tn="tmux new -s "
alias tkill="tmux kill-server"

# Navigation
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0-inbox/"
alias ..="cd .."
alias ....="cd ../../"
alias ......="cd ../../../"
alias -- -="cd -"

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

# Docker
alias dockernuke="docker system prune -a --volumes --force"

# Dockerized Opencode
alias opencode='docker run --rm -it \
  -v "$(pwd):/workspace" \
  -v ~/.config/opencode:/home/dev/.config/opencode \
  jihillestad/opencode'


# Dockerized Azure CLI
# alias exparm="export ARM_ACCESS_KEY=$(docker exec azure-cli sh -c 'cat /tmp/ARM_ACCESS_KEY.txt')"

# Dockerized Terraform
# alias dtfinit="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest init"
# alias dtfinitrc="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest init -reconfigure"
# alias dtfplan="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest plan -out main.tfplan"
# alias dtfapply="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest apply main.tfplan"
# alias dtfdestroy="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest destroy"
# alias dtfrefresh="docker run -i -t --rm -v "$(pwd):/workspace" -w /workspace -e ARM_ACCESS_KEY=$ARM_ACCESS_KEY hashicorp/terraform:latest refresh"

# Easier shell config
alias eb='v ~/.bashrc'
alias ez='v ~/.zshrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias szr='source ~/.zshrc'

# ricing (Alacritty)
# alias alday='sed -i "" "s/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyo-night\.toml\"\]/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyonight_day\.toml\"\]/" $DOTFILES/alacritty.toml'
# alias alnight='sed -i "" "s/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyonight_day\.toml\"\]/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyo-night\.toml\"\]/" $DOTFILES/alacritty.toml'
# alias termnight="$DOTFILES/scripts/termnight.sh"
# alias termday="$DOTFILES/scripts/termday.sh"

# fzf
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v "$(fp)"'

# zoxide
alias cd="z"

# Aliases for applications
alias skim='open /Applications/Skim.app/'
alias word='open /Applications/Microsoft\ Word.app'
alias excel='open /Applications/Microsoft\ Excel.app'
alias chrome='open /Applications/Google\ Chrome.app'
alias cn="chrome -n"
