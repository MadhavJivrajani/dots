# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

GIT_PS1_DESCRIBE_STYLE='contains'
GIT_PS1_SHOWCOLORHINTS='y'
GIT_PS1_SHOWDIRTYSTATE='y'
GIT_PS1_SHOWSTASHSTATE='y'
GIT_PS1_SHOWUNTRACKEDFILES='y'
GIT_PS1_SHOWUPSTREAM='auto'

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

git_prompt() {
	GIT_PROMPT=$(__git_ps1)
	TRIMMED=${GIT_PROMPT:2:(-1)}

	NC='\033[0m'

	BACKGROUND='\033[45m'
	FOREGROUND='\033[01;30m'
	FOREGROUND_BG='\033[01;35m'
	BRANCH='\uE0A0'

	ARROW="${NC}${FOREGROUND_BG}\uE0B0"
	if [[ $TRIMMED ]]; then
		echo -e "${BACKGROUND}${FOREGROUND} ${BRANCH} ${TRIMMED} ${ARROW}" 2> /dev/null
	fi
}

user_host_prompt() {
	BACKGROUND='\033[42m'
	FOREGROUND='\033[01;30m'
	ARROW_FG='\033[01;32m'
	NC='\033[0m'
	NEXT_BG='\033[46m'
	USER_PROMPT="${FOREGROUND}$(whoami)"
	HOST_PROMPT="${FOREGROUND}$(hostname)"
	END_ARROW="${NEXT_BG}${ARROW_FG}\uE0B0"
	echo -e "${BACKGROUND}${FOREGROUND}⎈ ${USER_PROMPT}@${HOST_PROMPT} ${END_ARROW}" 2> /dev/null
}

path_prompt() {
	BACKGROUND='\033[46m'
	NEXT_BG='\033[45m'

	FOREGROUND='\033[01;30m'
	ARROW_FG='\033[01;36m'
	NC='\033[0m'
	FOREGROUND_BG='\033[01;36m'
	ARROW="${NC}${FOREGROUND_BG}\uE0B0"
	PATH_PROMPT="${FOREGROUND}$(dirs +0)"

	# check if pwd is a git repo and render
	# prompt accordingly
	GIT_PROMPT=$(__git_ps1)
	TRIMMED=${GIT_PROMPT:2:(-1)}
	if [[ $TRIMMED ]]; then
		ARROW="${NEXT_BG}${ARROW_FG}\uE0B0"
	fi
	echo -e "${BACKGROUND} ${PATH_PROMPT} ${ARROW}"
}

source /etc/environment
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/snap/bin
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=/home/maddy/golib
export PATH=$PATH:$GOPATH/bin
export GOPATH=/home/maddy/gocode
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/kubebuilder/bin

PS1='\n$(user_host_prompt)\[\033[0;36m\]$(path_prompt)\[\033[0;35m\]$(git_prompt)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶ \[\033[00m\] '
