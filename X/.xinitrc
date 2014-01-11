#!/usr/bin/env bash

# Explanation: Let us keep in $HOME/.config/startx empty files, if a file has the same name as the
# case indicated here, follow appropriate action for that file. I.e. If we have $HOME/.config/startx/xmodmap,
# then start xmodmap, otherwise do nothing for xmodmap.
if [[ -d $HOME/.config/startx ]]; then
    for arguments in $(find $HOME/.config/startx/ -type f)
    do
        case $arguments in
            *xmodmap)
                # Start custom bind of keys
                xmodmap $HOME/.config/xmodmap
                shift ;;
            *gkeyring)
                source /etc/X11/xinit/xinitrc.d/30-dbus
                eval $(/usr/bin/gnome-keyring-daemon --start)
                export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK SSH_AGENT_PID
                shift ;;
            *udiskie)
                # Let's start udiskie (udisks wrapper)
                udiskie -s &
                shift ;;
            *xresources)
                # Start custom settings for urxvt
                xrdb -merge ~/.config/Xresources
                shift ;;
            *bell) # Turn the bell off
                xset -b
                shift ;;
            *fonts)
                xset +dpms +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts
                shift ;;
            default)
                echo "default case hit"
                shift ;;
        esac
    done
fi

# Let's set a pointer
xsetroot -cursor_name left_ptr

# Use $XDG_RUNTIME_DIR for some folders
mkdir -p $XDG_RUNTIME_DIR/{adobe,macromedia}
ln -sfn $XDG_RUNTIME_DIR/adobe ~/.adobe
ln -sfn $XDG_RUNTIME_DIR/macromedia ~/.macromedia

# Which WM/DE to launch
exec xmonad
# exec i3
# exec startxfce4
