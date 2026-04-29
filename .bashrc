# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# set starting director to ~
cd

export PATH
PATH=$PATH:/home/ryan/dev/flutter/bin/

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
export HISTFILESIZE=1000000000 #increase the size
export HISTSIZE=1000000000 #increase the size
shopt -s histappend #append instead of restarting on each new session
# Append commands to the history every time a prompt is shown,
# instead of after closing the session. -- this sometimes causes issues,
# commenting for now
#export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Git credentials
export GIT_AUTHOR_NAME="Ryan Baker"
export GIT_AUTHOR_EMAIL="ryan@compoundeye.com"
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_COMMITTER_EMAIL


function ce_ssh {
    local prefix=$1
    local num=$2
    local host=""

    # Try .local first
    if timeout 0.5 getent hosts ${prefix}-${num}.local &>/dev/null; then
        host="${prefix}-${num}.local"
    elif getent hosts ${prefix}-${num}.rwc.compoundeye.com &>/dev/null; then
        host="${prefix}-${num}.rwc.compoundeye.com"
    else
        # Just try the host without anything appended
        host="${prefix}-${num}"
    fi

    ~/dev/CompoundEye-CUDA/env/ce_ssh.sh ce@${host}
}

function agx {
    ce_ssh agx $1
}

function nx {
    ce_ssh nx $1
}

function zopa {
    ssh -p2222 -i ~/.ssh/zopa_id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$1
}

vpn() {
    case "$1" in
        on)
            sudo systemctl start warp-svc
            while [ ! -S /run/cloudflare-warp/warp_service ]; do
                sleep 0.5
            done
            warp-cli connect
            warp-cli status
            ;;
        off)
            if systemctl is-active --quiet warp-svc; then
                warp-cli disconnect
                sudo systemctl stop warp-svc
            else
                echo "VPN is already off"
            fi
            ;;
        *)
            echo "Usage: vpn [on|off]"
            ;;
    esac
}

SED_VERSION=`sed --version 2>&1 | head -1 | cut -f4 -d' '`
if [ "$SED_VERSION" != "4.1.5" ]; then
    export PS1='[\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\] `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\/`\[\033[137m\]]$ '
fi

