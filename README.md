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
Note that .vim/autoload has a symlink to .vim/bundle/pathogen/autoload/pathogen.vim, if you start vim without installing pathogen first then vim will scream at you.

Additionally, you can just run `./deploy --vim` and the required folders will be made for you. Also, this command will install the list of plugins mentioned bellow, and lastly
the appropriate symlinks will be created with the help of stow. Note that you need to have stow installed in order for the deploy script to function properly.

### Plugins
List of plugins I use:
- [pathogen](https://github.com/tpope/vim-pathogen)
- [commentary](https://github.com/tpope/vim-commentary)
- [ultisnips](https://github.com/SirVer/ultisnips)
- [NERDtree](https://github.com/vim-scripts/The-NERD-tree)
- [gist-vim](https://github.com/mattn/gist-vim)
- [webapi-vim](https://github.com/mattn/webapi-vim)
- [tabular](https://github.com/godlygeek/tabular.git)
- [SingleCompile](https://github.com/xuhdev/SingleCompile)
- [Syntastic](https://github.com/scrooloose/syntastic)

### Install as git submodule
```
git submodule add git://github.com/tpope/vim-pathogen.git vim/.vim/bundle/pathogen
git submodule add git://github.com/tpope/vim-commentary.git vim/.vim/bundle/vim-commentary
git submodule add git://github.com/SirVer/ultisnips.git vim/.vim/bundle/ultisnips
git submodule add git://github.com/scrooloose/nerdtree.git vim/.vim/bundle/nerdtree
git submodule add git://github.com/mattn/gist-vim vim/.vim/bundle/gist-vim
git submodule add git://github.com/mattn/webapi-vim vim/.vim/bundle/webapi-vim
git submodule add git://github.com/Lokaltog/vim-easymotion.git vim/.vim/bundle/easymotion
git submodule add git://github.com/godlygeek/tabular.git vim/.vim/bundle/tabular
git submodule add https://github.com/xuhdev/SingleCompile.git vim/.vim/bundle/single-compile
git submodule add https://github.com/scrooloose/syntastic.git vim/.vim/bundle/syntastic
git submodule add https://github.com/majutsushi/tagbar.git vim/.vim/bundle/tagbar
```

### Update all/single vim plugins
- git submodule foreach git pull origin master
- cd .vim/bundle/example && git pull origin master
