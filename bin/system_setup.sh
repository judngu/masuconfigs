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
brew install thefuck
brew install jrnl
brew install cmake # used by yajl
brew install jq # json parser
brew install homebrew/dupes/expect # gets you unbuffer
brew install rlwrap

### for spacemacs https://github.com/syl20bnr/spacemacs
brew tap railwaycat/homebrew-emacsmacport
brew install emacs-mac --with-spacemacs-icon
### end spacemacs

brew linkapps
# links the experimental Emacs.app (from spacemacs) to /Applications
# along with anything else that needs to be linked there
# could just do brew linkapps emacs-mac 

mkdir -p ~/workspace/reference

cd ~/workspace/reference
git clone git://github.com/lloyd/yajl
cd yajl
./configure && make install
#^^^ json formatting library
#    gives you json_reformat and json_verify

# support for sup email client
brew tap homebrew/dupes
brew install ncurses
brew doctor
brew link ncurses # might require a --force
brew install msmtp
# end sup

cd ~/workspace/home_dir_configs
git submodule init
git submodule update
ln -s ~/workspace/home_dir_configs/.vim/bundle ~/.vim/bundle
ln -s ~/workspace/home_dir_configs/slime.vim ~/slime.vim
ln -s ~/workspace/home_dir_configs/.emacs ~/.emacs
### spacemacs
#ln -s ~/workspace/home_dir_configs/.emacs.d ~/.emacs.d
if [ -e "~/.emacs.d" ]; then
	mv ~/.emacs.d ~/.emacs.bak.was.dot.d
fi
git clone --recursive git@github.com:syl20bnr/spacemacs.git ~/.emacs.d
ln -s ~/workspace/home_dir_configs/.spacemacs ~/.spacemacs
### end spacemacs

ln -s ~/workspace/home_dir_configs/.vimrc ~/.vimrc
ln -s ~/workspace/home_dir_configs/.vim ~/.vim

ln -s ~/workspace/home_dir_configs/.ackrc ~/.ackrc
ln -s ~/workspace/home_dir_configs/.clisprc.lisp ~/.clisprc.lisp


ln -s ~/workspace/home_dir_configs/.darcs ~/.darcs
ln -s ~/workspace/home_dir_configs/.git-completion.bash ~/.git-completion.bash

ln -s ~/workspace/home_dir_configs/bin ~/bin

cp -r ~/workspace/home_dir_configs/Library/Fonts/* ~/Library/Fonts/

ln -s ~/workspace/home_dir_configs/.oh-my-git ~/.oh-my-git
ln -s ~/workspace/home_dir_configs/.git-templates ~/.git-templates

ln -s ~/workspace/cleandiff/cdiff ~/bin/cdiff

ln -s ~/workspace/home_dir_configs/.taskrc ~/.taskrc

# setup CCL
mkdir -p /usr/local/src
ln -s /Applications/ccl/scripts/ccl ~/bin/ccl
ln -s /Applications/ccl/dx86cl /usr/local/src/ccl/dx86cl
ln -s /Applications/ccl /usr/local/src/ccl
ln -s ~/workspace/home_dir_configs/.ccl-init.lisp ~/.ccl-init.lisp

# fish shell config
ln -s ~/workspace/home_dir_configs/.config ~/.config


# command-t should already be installed via a vimball stored in the git repo
# https://wincent.com/products/command-t

# disable the @#$%@#$ back and forth swipe in chrome
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE


# install chicken scheme stuff
brew install readline
readline_version=$(brew list readline --versions)
readline_version=${readline_version##* }
export CSC_OPTIONS="-I/usr/local/Cellar/readline/$readline_version/include -L/usr/local/Cellar/readline/$readline_version/lib -Wl,-flat_namespace,-undefined,suppress"
unset readline_version
brew install chicken
chicken-install readline
chicken-install chicken-doc
chicken-install linenoise
chicken-install loops
chicken-install directory-utils
chicken-install regex
cd `csi -p '(chicken-home)'`
curl http://3e8.org/pub/chicken-doc/chicken-doc-repo.tgz | sudo tar zx
# requires `chicken-install linenoise` to have been run first
ln -s ~/workspace/home_dir_configs/.csirc ~/.csirc



#####
echo "MANUAL TODO:----------------------"
echo "add: /usr/local/bin/fish to /etc/shells"
echo "run: chsh -s /usr/local/bin/fish"
echo "run: rvm fish shell integration commands found here"
echo "     https://rvm.io/integration/fish"
