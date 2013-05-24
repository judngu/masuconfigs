#!/usr/bin/sh

#git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# to see changed lines use git lg -p
#git config --global alias.st "status -sb"

brew install ack
brew install ctags
brew install dwdiff
brew install gettext
brew install imagemagick
brew install readline
brew install ossp-uuid
brew install tig
brew instal hub

mkdir ~/workspace
cd workspace
git checkout ssh://masukomi@masukomi.org/home/masukomi/home_dir_configs.git
cd home_dir_configs
git submodule init
git submodule update
ln -s ~/workspace/home_dir_configs/.vim/bundle ~/.vim/bundle


# command-t should already be installed via a vimball stored in the git repo
# https://wincent.com/products/command-t
