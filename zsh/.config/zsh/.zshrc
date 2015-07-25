source $HOME/.antigen/antigen.zsh
source $HOME/.config/zsh/functions

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen-bundle common-aliases
antigen-bundle npm
antigen-bundle sudo
antigen bundle olivierverdier/zsh-git-prompt

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme gnzh

# Tell antigen that you're done.
antigen apply

PROMPT='%B%m%~%b$(git_super_status) %# '
dotfiles=$HOME/.dotfiles
source_if_exists $dotfiles/zsh/.config/zsh/config.$(short_hostname)
