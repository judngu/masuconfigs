#!/bin/sh

#git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# to see changed lines use git lg -p
#git config --global alias.st "status -sb"

brew install ack
brew install fish
brew install glib
brew install libgpg-error
brew install little-cms2
brew install pkg-config
brew install xz
brew install autoconf
brew install fontforge
brew install hub
brew install libksba
brew install macvim
brew install postgresql
brew install automake
brew install fuse4x
brew install icu4c
brew install libtiff
brew install mercurial
brew install readline
brew install cloc
brew install fuse4x-kext
brew install imagemagick
brew install libtool
brew install mongodb
brew install sqlite
brew install cscope
brew install gettext
brew install jbig2dec
brew install libxml2
brew install mpack
brew install sshfs
brew install ctags
brew install ghostscript
brew install jpeg
brew install libxslt
brew install openssl
brew install uudeview
brew install dwdiff
brew install git
brew install libffi
brew install libyaml
brew install ossp-uuid
brew install tree
brew install moreutils


mkdir ~/workspace
cd workspace
git checkout ssh://masukomi@masukomi.org/home/masukomi/home_dir_configs.git
cd home_dir_configs
git submodule init
git submodule update
ln -s ~/workspace/home_dir_configs/.vim/bundle ~/.vim/bundle
ln -s ~/workspace/home_dir_configs/slime.vim ~/slime.vim
ln -s ~/workspace/home_dir_configs/.emacs ~/.emacs
ln -s ~/workspace/home_dir_configs/.emacs.d ~/.emacs.d


ln -s ~/workspace/home_dir_configs/.vimrc ~/.vimrc

ln -s ~/workspace/home_dir_configs/.ackrc ~/.ackrc
ln -s ~/workspace/home_dir_configs/.clisprc.lisp ~/.clisprc.lisp

# requires `chicken-install linenoise` to have been run first
ln -s ~/workspace/home_dir_configs/.csirc ~/.csirc


ln -s ~/workspace/home_dir_configs/.darcs ~/.darcs
ln -s ~/workspace/home_dir_configs/.git-completion.bash ~/.git-completion.bash

cp -r ~/workspace/home_dir_configs/Library/Fonts/* ~/Library/Fonts/

# setup CCL
mkdir -p /usr/local/src
ln -s /Applications/ccl/scripts/ccl ~/bin/ccl
ln -s /Applications/ccl/dx86cl /usr/local/src/ccl/dx86cl
ln -s /Applications/ccl /usr/local/src/ccl
ln -s ~/workspace/home_dir_configs/.ccl-init.lisp ~/.ccl-init.lisp


# command-t should already be installed via a vimball stored in the git repo
# https://wincent.com/products/command-t

# disable the @#$%@#$ back and forth swipe in chrome
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE
