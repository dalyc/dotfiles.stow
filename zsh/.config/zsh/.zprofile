# Set umask: 700 dirs / 700 files
#umask 077

export EDITOR="vim"
export VISUAL="vim"
export PATH="${PATH}:${HOME}/dev/bin:${HOME}/.cabal/bin:${HOME}/.gem/ruby/2.1.0/bin"
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

# Let us use human-readible formats
export BLOCKSIZE=human-readable

# Why don't more apps use XDG base dir specification? :(
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export KDEHOME="$XDG_CONFIG_HOME"/kde4
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/pystartup
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME"/gimp-2.8
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export PERL_CPANM_HOME="$XDG_CONFIG_HOME"/cpanm
export MPV_HOME="$XDG_CONFIG_HOME"/mpv
export VIMPERATOR_RUNTIME="$XDG_CONFIG_HOME"/vimperator
export PENTADACTYL_RUNTIME="$XDG_CONFIG_HOME"/pentadactyl
