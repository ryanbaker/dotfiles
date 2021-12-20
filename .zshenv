# .zshenv
# set the number of open files to be 1024
ulimit -S -n 1024
export LS_OPTIONS="--color -l"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# Source .profile, containing login, non-bash related initializations.
if [ -f ~/.profile ]; then
    source ~/.profile
fi
# Source .zshrc, containing non-login related bash initializations.
if [ -f ~/.zshrc ]; then
    source ~/.zshrc
fi

ssh-add -A 2>/dev/null
