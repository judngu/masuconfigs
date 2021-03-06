# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export USERNAME=`id -nu`
export ARCHFLAGS="-arch x86_64"
export EDITOR='vim'
export VISUAL='vim'
export GOPATH=/Users/$USERNAME/workspace/gocode
export CHICKEN_BUILD=/Users/$USERNAME/workspace/reference/scheme/chicken-4.10.0


bind '"\e[A": history-search-backward' #up-arrow through history
bind '"\e[B": history-search-forward' #down-arrow through history
set show-all-if-ambiguous on
set completion-ignore-case on
#set -o vi
#set set editing-mode vi

## throw this at the top of your .bash_profile
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo -e " \xE2\x98\xA2"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Public: current_git_branch returns the name of the 
#         current git branch (duh)
function current_git_branch {
	git rev-parse --abbrev-ref HEAD
}


# Combining Lachie Cox's crazy Git branch mojo:
#   http://spiral.smartbomb.com.au/post/31418465
# with 
#   http://henrik.nyh.se/2008/12/git-dirty-prompt
# AND Geoff Grosenbach's style:
#   http://pastie.org/325104
# Sweeeeeeeet!

# export PS1='\[\033[01;32m\]\w $(git branch &>/dev/null; if [ $? -eq 0 ]; 
# then echo -e "\[\033[01;34m\]$(current_git_branch)"; fi) \D{%M} $(echo -e "\xE2\x9E\x9C") \[\033[00m\]'

export PS1="\[\033[01;32m\]\w  $(echo -e "\xE2\x9E\x9C")\[\033[00m\] "
#export PS1="\[\033[01;32m\]\w →\[\033[00m\] "


NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function red() {
    echo -e "$RED$*$NORMAL"
}

function green() {
    echo -e "$GREEN$*$NORMAL"
}

function yellow() {
    echo -e "$YELLOW$*$NORMAL"
}


export TERM='xterm-256color'
# if you don't do that then the powerline in 
# vim has no color. I'm sure it screws something 
# else up too but that's the only thing I've encountered
# so far.
# The alternative is:
#        export TERM='xterm-color' 


#find and open
function fao {
	#find . -name $1 -exec /usr/bin/env gvim '{}' \;
	FILE=$(mdfind -onlyin . -name $1| grep -v '\.rsync_cache')
	# gvim $(mdfind -onlyin . -name $1| grep -v '\.rsync_cache')
	echo "opening: $FILE"
	gvim $FILE
	#gvim $(find . -name "$1" | grep -v '\.rsync_cache')
}
function findg {
	find $@ | grep -v "\.git" | grep -v "\.rsync_cache"
}
function fing {
	findg $@
}
# find a method
function findm {
	grep -rn $0 $1 | grep 'def'
}
#gpo: git push origin
function gpo {
	git push origin $(current_git_branch)
}
#gso: git suck origin 
function gso {
	# the S is for Suck!
	git fetch
	git pull origin $(current_git_branch)
}
function gsu {
	# the S is for Suck!
	# the U is for Upstream
	git fetch
	git pull upstream $(current_git_branch)
}

#gsor: git suck origin & rebase local changes on top
function gsor {
	git pull --rebase origin $(current_git_branch)
}
#god: git origin diff (what's different between your branch 
# and the one with the same name on origin
function god {
	git log origin/$(current_git_branch)..$(current_git_branch)
}

function gpm {
	git push masukomi $(current_git_branch)
}
function gsm {
	# the S is for Suck!
	git pull masukomi $(current_git_branch)
}
function gsmr {
	git pull --rebase masukomi $(current_git_branch)
}
function gmd {
	git log masukomi/$(current_git_branch)..$(current_git_branch)
}

function br {
	for file in *.$1; do
		mv $file `basename $file $1`.$2
	done
}


#alias cleandiff="dwdiff -A best -L -s -W \" _}{\x0A%'\\\"\" -c -d \",;/:.\" --diff-input -"
# git diff <treeish> | cleandiff
#alias cleandiff="dwdiff -A best -L -s -W \" _}{\x0A%'\\\"\" -c -d \",;/:.\" --diff-input -"
function cdprev(){
	if [ $# -gt 0 ]; then
		git difftool --tool=cdiff $1^ $1
	else
		git difftool --tool=cdiff HEAD^ HEAD 
	fi
}
# loads git difftool for the supplied treeish vs
# its predecessor OR for HEAD vs its predecessor.
function dprev(){
	if [ $# -gt 0 ]; then
		git difftool $1^ $1
	else
		git difftool HEAD^ HEAD
	fi
}

function runtimes() {
	number=$1
	shift
	for i in `seq $number`; do
		echo "runtimes RUN #$i"
		$@
	done
}

function gdef() {
	echo "running: grep -r $1 $2* | grep def"
	grep -r $1 $2* | grep def | grep -v "tags:"
}

# Public: Git Diff UPstream
#         Compare the current branch to the upstream version of itself.
function gdup {
	CURRENT_GIT_BRANCH=$(current_git_branch)
	REMOTE=$(git config --get "branch.$CURRENT_GIT_BRANCH.remote")
	if [ "$REMOTE" != "" ]; then
		MERGE=$(git config --get "branch.$CURRENT_GIT_BRANCH.merge" | sed -e 's/.*\///g')
		if [ "$MERGE" != "" ]; then
			echo "running: git difftool $REMOTE/$MERGE"
			git difftool "$REMOTE/$MERGE"
		else
			echo "nothing found in branch.$CURRENT_GIT_BRANCH.merge"
		fi
	else
		echo "nothing found in branch.$CURRENT_GIT_BRANCH.remote"
	fi
}


# Public: returns the name of the git remote the current branch is tracking
function get_git_remote {
  x=$(current_git_branch)
  remote=$(git config --get "branch.""$x"".remote")
  #if [ "$remote" == "" ]; then
  #  remote=$(git config --get "branch.""$x"".merge" | sed -e 's/.*\///g')
  #fi
  echo -ne $remote
  return
}


# Public: configures the ability to checkout GitHub PRs for the specified remote
# 
# args - name of the remote to configure this for.
function add_prs_to_remote {
	git config --add remote.$1.fetch "+refs/pull/*/head:refs/remotes/$1/pr/*"
	git fetch $1
}

source ~/workspace/gpup/gpup.sh

function protect_upstream {
	git remote set-url --push upstream you_really_shouldnt_push_to_upstream
}

# deletes remote branches
function kob {
	if [ $# -gt 0 ]; then
		git push origin :$1
	else
		git push origin :$(current_git_branch)
	fi
}

function rvmerize {
	echo "ruby-2.0.0-p195" > .ruby-version
	echo ${PWD##*/} > .ruby-gemset
}

raw_url_encode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

function google {
	URL="https://www.google.com/search?q=$(raw_url_encode "$1")"
	open $URL
}

function utest {
	bundle exec ruby -I"lib:test" test/unit/$1_test.rb
}

# superceeded by css_image script in PATH
#function css_image {
#	openssl base64 -in "$1" | awk -v ext="${1#*.}" '{ str1=str1 $0 }END{ print "background:url(data:image/"ext";base64,"str1");" }'
#}


#/usr/bin/keychain -q ~/.ssh/internal_key ~/.ssh/deployed_key ~/.ssh/external_key
#/usr/bin/ssh-add ~/.ssh/internal_key ~/.ssh/deployed_key ~/.ssh/external_key
# If not running interactively, don't do anything:
#[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
#if [ "$TERM" != "dumb" ]; then
#    eval "`dircolors -b`"
    #alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
#fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profiles
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

alias top="top -o cpu"
#Compensating for stupidity
alias givm=gvim
alias gvmi=gvim
alias be='bundle exec'
alias ga='git add'
alias gits='git status -uno'
#End stupidity...
alias epochtime="date +%s"
alias epochmillis="date +%s%N | cut -b1-13"
alias berc='bundle exec rails console'
alias bers='bundle exec rails server'
alias berd='bundle exec rails server --debugger'
alias berdm='bundle exec rake db:migrate'
alias build_tags="~/brew/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude=.rsync_cache ."
alias hgrep="history | grep"

#alias git=hub
alias grep="grep --color=always"
alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
alias be='bundle exec'
alias clojure="java -cp ~/workspace/clojure-1.5.1/clojure-1.5.1.jar clojure.main"


#source ~/workspace/z/z.sh

export LANG=en_US.UTF-8

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f ~/.config/exercism/exercism_completion.bash ]; then
    . ~/.config/exercism/exercism_completion.bash
fi

PATH=.:/usr/local/opt/coreutils/libexec/gnubin:/Users/$USERNAME/bin:/Users/$USERNAME/bin/git-scripts:/usr/local/rvm/bin:/usr/local/bin:$PATH:/Applications:/Users/$USERNAME/Applications:/Users/$USERNAME/Applications/bin:/Users/$USERNAME/workspace/git-status-report:/Users/$USERNAME/workspace/git_accessories:/usr/local/git/bin:/Users/$USERNAME/.gem/ruby/1.8/bin:/Users/$USERNAME/gocode/bin:$GOPATH/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
[[ -s "/usr/local/rvm" ]] && source "/usr/local/rvm" # This loads RVM into a shell session.




PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


if [ -f ~/.bash_work ]; then
    . ~/.bash_work
fi
if [ -f ~/workspace/useful_scripts/bash/.bashrc ]; then
    . ~/workspace/useful_scripts/bash/.bashrc
fi


source ~/.oh-my-git/prompt.sh


#source ~/.xsh
eval "$(thefuck --alias)"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PERLLIB=/usr/local/Cellar/perl/5.24.0_1/lib/perl5/site_perl/5.24.0:$PERLLIB

