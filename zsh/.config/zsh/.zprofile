# Set umask: 700 dirs / 700 files
#umask 077

export EDITOR="vim"
export VISUAL="vim"
export PATH="${PATH}:${HOME}/dev/bin:${HOME}/.cabal/bin:${HOME}/.gem/ruby/2.0.0/bin"
export PAGER="less"

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Colors
export GREP_OPTIONS='--color=auto'

# Highest compression
export GZIP=-9 \
  BZIP=-9 \
  XZ_OPT=-9

# Set location of gtk2 gtkrc (also needed for Qt's gtk style)
export GTK2_RC_FILES=$HOME/.config/gtk-2.0/gtkrc

# Set location for kde4 files
export KDEHOME=$HOME/.config/kde4

# For the interactive python interpreter
export PYTHONSTARTUP=$HOME/.config/pystartup

# Let us store Gimp settings in $HOME/.config
export GIMP2_DIRECTORY=$HOME/.config/gimp-2.8

# Let us store GPG settings and misc in $HOME/.config
export GNUPGHOME=$HOME/.config/gnupg

# Let us store mpv settings in $HOME/.config
export MPV_HOME=$HOME/.config/mpv
