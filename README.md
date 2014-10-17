License
-------
Feel free to use and modify anything on this repo as you wish.

How to clone the repo
---------------------
`git clone https://github.com/ballmerpeak/dotfiles.git ~/.dotfiles`

How to deploy?
--------------
This is up to each individual, but this repo is structured in a way that allows for the GNU stow utility to be used. Stow allows for very easy creation and deletion of symbolic links.
For example, if you want to grab use my vim configs you would just need to write `stow -v vim`, and after you get tired of my vim configs you just delete the symbolic links with `stow -v --delete vim`.
The deploy script on this repo is esentially just an alias for `stow -v cower git mutt newsbeuter termite unclassified vim X xmonad youtube zsh`

Dependencies
------------
- xmobar/dev/clipsync requires xclip and dmenu

Notes on ~/.xinitrc
-------------------
Notice that my xinitrc has some unusual behavior. You should create a folder called startx in $HOME/.config, and there create a set of empty files. For instance, if you create the file $HOME/.config/startx/udiskie, then udiskie will be started when you run startx. I encourage you to check the case statement in xinitrc.
Lastly, if my hostname is Greno and my $HOME is /home/user, then start xmonad, otherwise start the tiling window manager i3.


Notes on zsh
-------------
I have heavily personalized zlogin. Just like with xinitrc, zlogin makes use of the $HOME/.config/startx folder. If the file $HOME/.config/startx/startx exists, then when you log in X will be automatically started for you. That is, if you are logging in from tty1, 2, or 3. When you log in from tty3 the stdout and stderr will be redirected to the file $HOME/xlog. If $HOME/xlog already exists it will ask you to delete it to before starting X, so we may only keep the latest output. Also, note that if you log in from tty1 or 2 and your hostname is Greno, and the file $HOME/.config/startx/keychain exists, and you have script /usr/bin/keychain (indicative that you have keychain installed), then make use of this SSH agent. Of course, you will need to modify some lines in this if statement if you wish to make use of this.

I recommend you to check $HOME/.config/zsh/.zprofile to check the configured exports. For instance, I configured my PATH to `${PATH}:${HOME}/dev/bin:${HOME}/.cabal/bin:${HOME}/.gem/ruby/2.0.0/bin`. You may want to modify several settings here.

The last worthwhile thing to mention is that I have configured .zshrc so that it expects the following files:
- $HOME/.config/zsh/$HOST-alias
- $HOME/.config/zsh/$HOST-functions
Here you may keep host specific alias and functions, and if you decide to use my zsh settings across many machines, you may keep the base functions and aliases in:
- $HOME/.config/zsh/base-alias
- $HOME/.config/zsh/base-functions


Vim specifics
-------------

### Getting started
My vimrc expects certain directories within the .vim folder, so let us create them with `mkdir -p ~/.vim/{autoload,bundle,backup,swap}`
My vim config expects the Vundle vim plugin to be installed. If you start vim without installing Vundle first it will scream at you. The deploy script will do this automatically for you. The command would be: ./deploy --vim

### Plugins
For a list of all plugins I use check the lines that say Plugin in the vimrc file.
