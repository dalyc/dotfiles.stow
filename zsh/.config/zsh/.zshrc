#------------------------------
# Host specific and base bits
#------------------------------
if [[ $HOST == "Greno" ]]; then
    # http://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/
    # http://stackoverflow.com/questions/9336058/how-to-copy-existing-completions-to-other-commands-in-zsh
    # http://wikimatze.de/writing-zsh-completion-for-padrino.html
    # http://blog.mavjs.org/2012/07/zsh-autocomplete-function-to-change-and.html
    # http://superuser.com/questions/296256/whats-the-easiest-way-to-add-custom-filename-autocomplete-behavior-for-a-comman
    # Add custom completition
    fpath=($HOME/.config/zsh/autocompletitions $fpath)
    # Source functions and aliases if our hostname is Greno
    source $HOME/.config/zsh/Greno-alias
    source $HOME/.config/zsh/Greno-functions
    # Don't store commands with cd/ls/mirage/mpv in the history
    function zshaddhistory() { [[ $1 != *(cd|ls|mirage|mpv)* ]] }
else
    # Load custom aliases our host
    # if $HOME/.config/zsh/$HOST-alias exists
    if [[ -f $HOME/.config/zsh/"$HOST"-alias ]]; then
        source $HOME/.config/zsh/"$HOST"-alias
    fi
    # Load custom functions for our host
    # if $HOME/.config/zsh/$HOST-functions exists
    if [[ -f $HOME/.config/zsh/"$HOST"-functions ]]; then
        source $HOME/.config/zsh/"$HOST"-functions
    fi
fi

# Load base aliases and functions
source $HOME/.config/zsh/base-alias
source $HOME/.config/zsh/base-functions
source $HOME/.config/zsh/marks-function
# Load completition settings
source $HOME/.config/zsh/completition

# Enable C-S-t in termite which opens a new
# terminal in the same working directory
if [[ -n $VTE_VERSION ]]; then
    . /etc/profile.d/vte.sh
    __vte_osc7
fi

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
stty -ixon #disables ctrl+q and ctrl+s for pause&unpause
bindkey -e
bindkey ' ' magic-space # also do history expansion on space
bindkey "^[[3~" delete-char
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

#------------------------------
# Settings
#------------------------------
MAILCHECK=0                 # Disable mail checking
HISTFILE=~/.histfile        # The file to store the history
HISTSIZE=1000               # The internal history's size
SAVEHIST=1000               # The file history's size
#setopt COMPLETE_IN_WORD     # If unset, the cursor is set to the end of the word
                            # if completion is started. Otherwise it stays there
                            # and completion is done from both ends.
setopt CORRECT              # Try  to  correct the spelling of commands
setopt hist_ignore_dups     # Don't save same line in the history
setopt hist_verify          # Verify when using history
setopt hist_no_store        # Don't store the `history` command
setopt hist_ignore_space    # Don't store commands starting with a space
setopt no_bang_hist         # Never interpret !! in a special manner
setopt NO_BEEP              # Don't beep
setopt extendedglob         # Treat  the  `#',  `~' and `^' characters as part
                            # of patterns for filename generation, etc
setopt nomatch              # Print error when pattern for filename generates
                            # no matches
#setopt nonomatch            # Don't print error on non matched patterns
setopt notify               # Report status of background jobs immediately
setopt noclobber            # Requires >! to overwrite existing files

#------------------------------
# Window title
#------------------------------
if [[ $TERM = rxvt* ]]; then
    precmd () { print -Pn "\e]0;%n@%M [%~]\a" }
    preexec () { print -Pn "\e]0;%n@%M [%~] ($1)\a" }
fi

#------------------------------
# Prompt
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
#------------------------------
precmd() {
    # Let us change the color of the path if it's not writable
    # %3c = Only show last 3 dirs on our PWD
    # %d = Show full path to dir
    if [[ -w "$PWD" ]]; then
        eval PR_DIR='${PR_YELLOW}%3c${PR_NO_COLOR}'
    else
        eval PR_DIR='${PR_RED}%d${PR_NO_COLOR}'
    fi
}

setprompt() {
    # Required for colours
    autoload -U colors zsh/terminfo
    colors
    # Load some modules
    setopt prompt_subst
    # Make some aliases for the colours (could use normal esq seq too)
    for color in RED GREEN YELLOW BLUE MAGNETA CYAN WHITE; do
        eval PR_$color='%{$fg[${(L)color}]%}'
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"


    # Let us change the color of our username (%n) if we are in SSH
    if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
        eval PR_USER='${PR_RED}%n${PR_NO_COLOR}' #SSH
        # Also, let us export TERM
        export TERM=xterm
    else
        eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}' # no SSH
    fi


    PROMPT='${PR_USER}${PR_BLUE} in [${PR_DIR}${PR_BLUE}] ${PR_RED}#${PR_NO_COLOR} '
    # Print a right prompt with GIT info
    # https://github.com/olivierverdier/zsh-git-prompt
    source $HOME/.config/zsh/git-prompt/zshrc.sh
    RPROMPT='${PR_NO_COLOR}$(git_super_status)${PR_NO_COLOR}'
}

setprompt
