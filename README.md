License
-------
Feel free to use and modify anything on this repo as you wish.

How to clone the repo
---------------------
`git clone https://github.com/ballmerpeak/dotfiles.git ~/.dotfiles`

How to deploy?
--------------
This is up to each individual, but this repo is structured in a way that allows for the
GNU stow utility to be used. Stow allows for very easy creation and deletion of symbolic links.
For example, if you want to grab use my vim configs you would just need to write `stow -v vim`, and after
you get tired of my vim configs you just delete the symbolic links with `stow -v --delete vim`.
The deploy script on this repo is esentially just an alias for `stow -v --delete cower git mutt newsbeuter termite unclassified vim X xmonad youtube zsh`

Dependencies
------------
- xmobar/dev/clipsync requires xclip and dmenu

Vim specifics
-------------

### Getting started
My vimrc expects certain directories within the .vim folder, so let us create them
`mkdir -p ~/.vim/{autoload,bundle,backup,swap}`
Additionally, after installing pathogen as a submodule we will want to create a symbolic link
to start it automatically
`cd <dotfiles>/vim/.vim/autoload && ln -s ../bundle/pathogen/autoload/pathogen.vim`
Where <dotfiles> is the folder where we cloned this repo to, e.g. ~/dotfiles

### Plugins
List of plugins I use:
- [pathogen](https://github.com/tpope/vim-pathogen)
- [commentary](https://github.com/tpope/vim-commentary)
- [ultisnips](https://github.com/SirVer/ultisnips)
- [NERDtree](https://github.com/vim-scripts/The-NERD-tree)
- [gist-vim](https://github.com/mattn/gist-vim)
- [webapi-vim](https://github.com/mattn/webapi-vim)
- [tabular](https://github.com/godlygeek/tabular.git)

### Install as git submodule
```
git submodule add git://github.com/tpope/vim-pathogen.git vim/.vim/bundle/pathogen
git submodule add git://github.com/tpope/vim-commentary.git vim/.vim/bundle/vim-commentary
git submodule add git://github.com/SirVer/ultisnips.git vim/.vim/bundle/ultisnips
git submodule add git://github.com/scrooloose/nerdtree.git vim/.vim/bundle/nerdtree
git submodule add git://github.com/mattn/gist-vim vim/.vim/bundle/gist-vim
git submodule add git://github.com/mattn/webapi-vim vim/.vim/bundle/webapi-vim
git submodule add git://github.com/godlygeek/tabular.git vim/.vim/bundle/tabular
```

### Update all/single vim plugins
- git submodule foreach git pull origin master
- cd .vim/bundle/example && git pull origin master
