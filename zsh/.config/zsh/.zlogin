# 1st condition: Only attempt to start X if the file
# $HOME/.config/startx/startx exists
if [[ -f $HOME/.config/startx/startx ]]; then
    # If we log in from tty1 or tty2, then startx
    if [[ -z $DISPLAY && $(tty) = /dev/tty[12] ]]; then
        # If our hostname is Greno, start the keychain for ssh key management stuff.
        # If /usr/bin/keychain is not executable, then skip this section
        # If $HOME/.config/startx/keychain does not exist, skip this section
        if [[ $HOST = "Greno" ]] && [[ -x /usr/bin/keychain ]] && [[ -f $HOME/.config/startx/keychain ]]; then
            keychain --agents "gpg,ssh" --clear --dir $HOME/.ssh/.keychain $HOME/.ssh/id_rsa.ALARM 0DC771C4
            source $HOME/.ssh/.keychain/$HOST-sh
            source $HOME/.ssh/.keychain/$HOST-sh-gpg
        fi
        exec startx
    # If we log in from tty3, then start X and log output
    elif [[ -z $DISPLAY && $(tty) = /dev/tty3 ]]; then
        # What to do if the log output file exists
        if [[ -f $HOME/xlog ]]; then
            rm -i "$HOME"/xlog && exec startx &> ~/xlog
        # If the file does not exist, startx and create the log file
        else
            exec startx &> ~/xlog
        fi
    fi
fi
