# .zshrc

export PATH

# User specific aliases and functions
alias hadron='ssh -p223 hadron.cetoncorp.com'
alias knife='ssh -p222 knife.cetoncorp.com'
alias sigh='ssh ryan@sigh.ceton.net'
alias fios='ssh -p222 fios.ceton.net'
alias fabian='ssh fabian'
alias atx1='ssh -p2222 ceton@atxproto1'
alias atx2='ssh -p2222 ceton@atxproto2'
alias atx3='ssh -p2222 ceton@atxproto3'
alias kingsley='ssh -p2222 ceton@kingsley'
alias nave='ssh nave'
alias murphy='ssh murphy'
alias king='ssh mountainking'
alias wanderer='ssh wanderer'
alias tusseladd='ssh -p222 tusseladd'
alias thegstreamer='ssh thegstreamer'
alias nwg='ssh 10.211.55.3'
alias karno='ssh 10.211.55.6'
alias dracano='ssh dracano'
alias elysian='ssh elysian'
alias git-diff='reset | git diff'
alias diff='colordiff'

export EDITOR='vim'

export CLICOLOR=1
alias ll='ls -l'
alias la='ls -al'

alias grep="grep --color=auto"

# Avoid succesive duplicates in the bash command history.
export HISTSIZE=10000000 #increase the size
export SAVEHIST=10000000
setopt INC_APPEND_HISTORY #append instead of restarting on each new session
setopt SHARE_HISTORY
setopt HIST_SAVE_NO_DUPS
# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
export PROMPT_COMMAND='history -a'

function ecco {
    ssh -p2222 -i ~/.ssh/mcx_id_rsa root@$1
}
function zopa {
    ssh -p2222 -i ~/.ssh/zopa_id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$1
}

bindkey '^R' history-incremental-search-backward
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
zstyle ':vcs_info:*' enable git

SED_VERSION=`sed --version 2>&1 | head -1 | cut -f4 -d' '`
if [ "$SED_VERSION" != "4.1.5" ]; then
    #export PS1='[\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\] `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\/`\[\033[37m\]]$ '
    export PS1="[%F{magenta}%m %F{yellow}%~ %f\$vcs_info_msg_0_]$ "
fi


