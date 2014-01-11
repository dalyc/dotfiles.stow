#
# .bashrc - interactive shell configuration
#

# check for interactive
[[ $- = *i* ]] || return

export TTY=$(tty)
export GPG_TTY=$TTY

ulimit -S -c 0 # disable core dumps
stty -ctlecho # turn off control character echoing

# Set my PS1
PS1='[\u@\h \W]\$ '

# Aliases
alias ls='ls --color=auto'
alias mutt='mutt -F $HOME/.config/mutt/muttrc'

# TERM settings
if [[ -n "$TMUX" ]]; then
    export TERM=screen-256color
else
    export TERM=xterm
fi
