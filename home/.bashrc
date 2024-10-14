#!/bin/bash
os=`uname`

alias ls='ls --color=auto'
alias noh='history -d $(history 1)'

# run local bash stuff (pc-specific aliases and such)
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

source ~/.exports
source $HOME/.homesick/repos/homeshick/homeshick.sh

PATH=$PATH:$HOME/bin

# Powerline Bash Prompt Setup https://github.com/b-ryan/powerline-shell#bash
export CLICOLOR=1
# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

###############################################################################
# Shortcuts                                                                   #
###############################################################################
mkdir -p ~/mongodata
alias doamongo='docker run --name mongo -d -v ~/mongodata:/data/db -p 27017:27017 mongo'
alias doarabbit='docker run -p 15672:15672 -d --hostname myrabbit --name rabbit rabbitmq:3-management'

alias yt='yt-dlp'
alias k='kubectl'

alias noh='history -d $(history 1)'

alias ll='ls -alFt'
alias l='ls -CF'

# alias homesick-push='cd ~/.homesick/repos/dotfiles-full && git add -A && git commit -m "random update" && git push'
alias homesick-pull='homeshick pull dotfiles-full'

alias stable="(trap 'kill 0' SIGINT; cd /media/ccc/evil-morty/projects/image-gen/stable-diffusion-webui && ls && ./webui.sh --listen & . /media/ccc/evil-morty/projects/machine-learning/stable-diffusion-slack/.venv/bin/activate && cd /media/ccc/evil-morty/projects/machine-learning/stable-diffusion-slack && python ez_slack.py)"
alias stable_only="(trap 'kill 0' SIGINT; cd /media/ccc/evil-morty/projects/image-gen/stable-diffusion-webui && ls && ./webui.sh --listen)"
alias sds='cd /media/ccc/evil-morty/projects/machine-learning/stable-diffusion-slack'

hotel_wifi() {
    # Extract the default gateway IP from the output of `ip route`
    GATEWAY_IP=$(ip route | awk '/default/ {print $3}')

    # Check if the gateway IP is non-empty
    if [ -z "$GATEWAY_IP" ]
    then
        echo "No default gateway found. Are you connected to a network?"
    else
        # Open the default gateway IP in Google Chrome
        google-chrome-stable "http://$GATEWAY_IP"
    fi
}


if [[ "$os" == 'Linux' ]]; then
  # Linux Business
  alias gh="google-chrome-stable https://github.com"
  alias ex='nautilus . &'
 elif [[ "$os" == 'Darwin' ]]; then
  # Mac Business
  alias ex='open . &'
fi

alias cccapi="cd /media/ccc/evil-morty/projects/cason/ccc_api && . venv/bin/activate && python server.py & ngrok http --region=us --domain=$NGROK_DOMAIN 5005"
alias vvv=". venv/bin/activate"

alias gitlogs='git log --decorate --graph --oneline --all'

alias killds='rm -f $(find . -name ".DS_Store" -type f)'

alias resource='source ~/.bash_profile && echo "Done!"'
alias whatsmyip='ipconfig getifaddr en0'

# File System stuff.
alias cpwd='pwd|tr -d "\n"|pbcopy' # copy pwd
alias ..="cd ../"
alias ...="cd ../../"

# List declared aliases, functions
alias listaliases="alias | sed 's/=.*//'"
alias listfunctions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'" # show non _prefixed functions

###############################################################################
# OSX                                                                         #
###############################################################################

if [[ "$os" == 'Darwin' ]]; then
  # Show/hide desktop icons
  alias desktopShow="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
  alias desktopHide="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

  # Show/hide hidden files by default
  alias hiddenFilesShow="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hiddenFilesHide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  # Show/hide all filename extensions
  alias fileExtensionsShow="defaults write NSGlobalDomain AppleShowAllExtensions -bool true && killall Finder"
  alias fileExtensionsHide="defaults write NSGlobalDomain AppleShowAllExtensions -bool false && killall Finder"
fi

################
# Docker
################

# alias dockerstop
# alias dockerkill
alias dockerps='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}"'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't tab autocomplete when empty
shopt -s no_empty_cmd_completion

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Avoid duplicates
export HISTCONTROL=ignoreboth:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# add something to gitignore
function gi {
  echo "$1" >> .gitignore
}

# grab the ip of a docker contanier by name
function dockerip {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}

function docker-clean {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# source ~/.prompt

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_com pletion

function yts() {
    yt-dlp --extract-audio --audio-format mp3 "$1"
}

function vaporize() {
    yt-dlp --extract-audio --audio-format mp3 --output "temp.mp3" "$1"
    sleep 10
    ffmpeg -i temp.mp3 temp.wav
    sox temp.wav slow.wav speed 0.75
    # sox temp.wav slow.wav tempo 0.76
    sox slow.wav verb.wav reverb 80 0 66 77 0 5
    ffmpeg -i verb.wav $2
    rm temp.wav slow.wav verb.wav temp.mp3
}

function sloworize() {
    youtube-dl --extract-audio --audio-format mp3 --output "temp.mp3" "$1"
    sleep 60
    ffmpeg -i temp.mp3 temp.wav
    sox temp.wav slow.wav tempo 0.96
    ffmpeg -i slow.wav $2
    rm temp.wav slow.wav temp.mp3
}

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

BROWSER=/usr/bin/google-chrome

# Cuda 12.6...
export PATH=/usr/local/cuda-12.6/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
