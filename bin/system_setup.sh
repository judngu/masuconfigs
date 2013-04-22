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

# vim plugins
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone git://github.com/godlygeek/tabular.git
git clone https://github.com/kchmck/vim-coffee-script.git
git clone git://github.com/tpope/vim-endwise.git
git clone git://github.com/tpope/vim-fugitive.git
