License
-------
Feel free to use and modify anything on this repo as you wish.

How to clone the repo
---------------------
`git clone https://github.com/dalyc/dotfiles.git ~/.dotfiles`

How to deploy?
--------------
This is up to each individual, but this repo is structured in a way that allows for the GNU stow utility to be used. Stow allows for very easy creation and deletion of symbolic links.
For example, if you want to grab use my vim configs you would just need to write `stow -v vim`, and after you get tired of my vim configs you just delete the symbolic links with `stow -v --delete vim`.
The deploy script on this repo is esentially just an alias for `stow -v git newsbeuter vim zsh`

Dependencies
------------
- xmobar/dev/clipsync requires xclip and dmenu


Notes on zsh
-------------
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
