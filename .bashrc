# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

export PATH

# User specific aliases and functions
alias karno='ssh 10.211.55.6'
alias git-diff='reset | git diff'
alias diff='colordiff'

export EDITOR='vim'

#export CLICOLOR=1
alias ll='ls -l'
alias la='ls -al'

alias grep="grep --color=auto"

# Avoid succesive duplicates in the bash command history.
export HISTCONTROL=ignoredups
export HISTFILESIZE=1000000 #increase the size
shopt -s histappend #append instead of restarting on each new session
# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

function agx {
    ssh ce@agx-$1
}

function zopa {
    ssh -p2222 -i ~/.ssh/zopa_id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$1
}

SED_VERSION=`sed --version 2>&1 | head -1 | cut -f4 -d' '`
if [ "$SED_VERSION" != "4.1.5" ]; then
    export PS1='[\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\] `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\/`\[\033[37m\]]$ '
fi

