# basics
export EDITOR=nvim
export PROMPT_COMMAND='history -a'
export HISTSIZE=100000
shopt -s histappend

# prompt
git_branch () {
  git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/'
}

branch_prompt () {
  BRANCH=$(git_branch)
  if [ -n "$BRANCH" ]; then echo -n " $BRANCH"; fi
}

PS1="\[\e[0m\][\[\e[36;40m\]\u\[\e[0m\]@\[\e[36;40m\]\h\[\e[0m\] \[\e[32;40m\]\w\[\e[0m\]\[\e[33;40m\]\$(branch_prompt)\[\e[0m\]]$ \[\e[0m\]"

# aliases
alias ls="ls -G"
alias ll="ls -al"
alias grep="grep --color"
alias stripcolors="sed -e 's/\\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g'"
alias vim="nvim"
alias vimdiff="nvim -d"
alias be="bundle exec"

alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
eval "$(hub alias -s)"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/git/tools/shell-scripts:$PATH"

# typos
alias bim="vim"
alias got="git"
alias giit="git"

# lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# node.js
# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# ruby
# eval "$(rbenv init -)"

# python
# export PATH="/usr/local/opt/python@3.8/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

# tmux
alias tmux="tmux -2"
alias irssi="TERM='screen-256color' irssi"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Fix font smoothing in wine
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"
launchctl setenv FREETYPE_PROPERTIES $FREETYPE_PROPERTIES
