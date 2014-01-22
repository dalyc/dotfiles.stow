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

### Install as git submodule
```
git submodule add git://github.com/tpope/vim-pathogen.git vim/.vim/bundle/pathogen
git submodule add git://github.com/tpope/vim-commentary.git vim/.vim/bundle/vim-commentary
git submodule add git://github.com/SirVer/ultisnips.git vim/.vim/bundle/ultisnips
git submodule add git://github.com/scrooloose/nerdtree.git vim/.vim/bundle/nerdtree
git submodule add git://github.com/mattn/gist-vim vim/.vim/bundle/gist-vim
git submodule add git://github.com/mattn/webapi-vim vim/.vim/bundle/webapi-vim
git submodule add git://github.com/godlygeek/tabular.git vim/.vim/bundle/tabular
git submodule add https://github.com/xuhdev/SingleCompile.git vim/.vim/bundle/single-compile
```

### Update all/single vim plugins
- git submodule foreach git pull origin master
- cd .vim/bundle/example && git pull origin master
