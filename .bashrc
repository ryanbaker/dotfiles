# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH

# User specific aliases and functions
alias hadron='ssh -p223 hadron.cetoncorp.com'
alias knife='ssh -p222 knife.cetoncorp.com'
alias fabian='ssh fabian'
alias atx1='ssh -p2222 ceton@atxproto1'
alias atx2='ssh -p2222 ceton@atxproto2'
alias atx3='ssh -p2222 ceton@atxproto3'
alias kingsley='ssh -p2222 ceton@kingsley'
alias nave='ssh nave'
alias murphy='ssh murphy'
alias king='ssh mountainking'
alias wanderer='ssh wanderer'
alias tusseladd='ssh tusseladd'
alias dracano='ssh dracano'
alias elysian='ssh elysian'
alias git-diff='reset | git diff'
alias diff='colordiff'

# Setup logcat for Mcx
TAGS='cetonmcx McxActivity McxService ConnectingActivity McxAudioRunnable mcx-jni audio_hw_primary DEBUG'
function logcat {
    if [ $1 ]; then
        cat $1 | python ~/dotfiles/coloredlogcat.py
    else
        adb logcat -v time $TAGS *:E | python ~/dotfiles/coloredlogcat.py
    fi
}
alias dumpstats='adb shell am broadcast -a com.ceton.mcx.DUMPSTATS'

export EDITOR='vim'

export CLICOLOR=1
alias ll='ls -l'
alias la='ls -al'

alias grep="grep --color=auto"

# Avoid succesive duplicates in the bash command history.
export HISTCONTROL=ignoredups
export HISTFILESIZE=100000 #increase the size
shopt -s histappend #append instead of restarting on each new session
# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
export PROMPT_COMMAND='history -a'

function ecco {
    ssh -p2222 -i ~/.ssh/mcx_id_rsa root@$1
}

PS1='[\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\] `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\/`\[\033[37m\]]$ '


