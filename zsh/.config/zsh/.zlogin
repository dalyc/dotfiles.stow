# Only attempt to start X if we login from tty1 or tty2
# AND $HOME/dev/bin/startxng exists
if [[ -z $DISPLAY && $(tty) = /dev/tty[12] ]] && [[ -f $HOME/dev/bin/startxng ]]; then
  # # Start the keychain for ssh key management stuff
  # # If /usr/bin/keychain is not executable, then skip this section
  # if [[ -x /usr/bin/keychain ]]; then
  #   keychain --agents "gpg,ssh" --clear --dir $HOME/.ssh/.keychain $HOME/.ssh/id_rsa.ALARM 0DC771C4
  #   source $HOME/.ssh/.keychain/$HOST-sh
  #   source $HOME/.ssh/.keychain/$HOST-sh-gpg
  # fi

  # Start X
  $HOME/dev/bin/startxng
fi
