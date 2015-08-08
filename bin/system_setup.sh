#!/bin/sh

#git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# to see changed lines use git lg -p
#git config --global alias.st "status -sb"

brew install ack
brew install autoconf
brew install automake
brew install clisp
brew install cloc
brew install cscope
brew install ctags
brew install dwdiff
brew install enca
brew install fish
brew install fontforge
brew install fuse4x
brew install fuse4x-kext
brew install gettext
brew install ghostscript
brew install git
brew install glib
brew install hub
brew install icu4c
brew install imagemagick
brew install jbig2dec
brew install jpeg
brew install libffi
brew install libgpg-error
brew install libksba
brew install libtiff
brew install libtool
brew install libxml2
brew install libxslt
brew install libyaml
brew install little-cms2
brew install macvim
brew install mercurial
brew install mongodb
brew install moreutils
brew install mpack
brew install openssl
brew install ossp-uuid
brew install pkg-config
brew install postgresql
brew install readline
brew install sqlite
brew install sshfs
brew install tree
brew install uudeview
brew install xz
brew install gpg
brew install tig
brew install pgcli


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
ln -s ~/workspace/home_dir_configs/.vim ~/.vim

ln -s ~/workspace/home_dir_configs/.ackrc ~/.ackrc
ln -s ~/workspace/home_dir_configs/.clisprc.lisp ~/.clisprc.lisp

# requires `chicken-install linenoise` to have been run first
ln -s ~/workspace/home_dir_configs/.csirc ~/.csirc


ln -s ~/workspace/home_dir_configs/.darcs ~/.darcs
ln -s ~/workspace/home_dir_configs/.git-completion.bash ~/.git-completion.bash

ln -s ~/workspace/home_dir_ctonfigs/bin ~/bin

cp -r ~/workspace/home_dir_configs/Library/Fonts/* ~/Library/Fonts/

ln -s ~/workspace/home_dir_configs/.oh-my-git ~/.oh-my-git
ln -s ~/workspace/home_dir_configs/.git-templates ~/.git-templates

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
