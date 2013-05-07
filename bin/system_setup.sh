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

# vim plugins
# we're cding in and calling git update after clone
# so that we can run it and have it be useful even 
# if the repo has already been cloned.
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone git://github.com/godlygeek/tabular.git
cd tabular
git update
cd ../
git clone https://github.com/kchmck/vim-coffee-script.git
cd vim-coffee-script
git update
cd ../
git clone git://github.com/tpope/vim-endwise.git
cd vim-endwise
git update
cd ../
git clone git://github.com/tpope/vim-fugitive.git
cd vim-fugitive
git update 
cd ../

# command-t should already be installed via a vimball stored in the git repo
# https://wincent.com/products/command-t
