# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export USERNAME=`id -nu`
export ARCHFLAGS="-arch x86_64"

bind '"\e[A": history-search-backward' #up-arrow through history
bind '"\e[B": history-search-forward' #down-arrow through history
set show-all-if-ambiguous on
set completion-ignore-case on



## throw this at the top of your .bash_profile
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo -e " \xE2\x98\xA2"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Public: current_git_branch returns the name of the 
#         current git branch (duh)
function current_git_branch { #not used by anything, just useful
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}


# Combining Lachie Cox's crazy Git branch mojo:
#   http://spiral.smartbomb.com.au/post/31418465
# with 
#   http://henrik.nyh.se/2008/12/git-dirty-prompt
# AND Geoff Grosenbach's style:
#   http://pastie.org/325104
# Sweeeeeeeet!

export PS1='\[\033[01;32m\]\w $(git branch &>/dev/null; if [ $? -eq 0 ]; 
then echo "\[\033[01;34m\]$(parse_git_branch)"; fi) \D{%M} \$ \[\033[00m\]'


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



#find and open
function fao {
	#find . -name $1 -exec /usr/bin/env gvim '{}' \;
	gvim $(mdfind -onlyin . -name $1| grep -v '\.rsync_cache')
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
# git diff <treeish> | cleandiff
function cdiff(){
	git diff $@ | cleandiff
}
function cleandiff(){
	dwdiff -A best -L -s -W " _}{\x0A%'\"" -c -d ",;/:." --diff-input -
}

# generates a cleandiff for the supplied treeish vs
# its predecessor OR for HEAD vs its predecessor.
function cdprev(){
	if [ $# -gt 0 ]; then
		git diff $1^ $1 | cleandiff
	else
		git diff HEAD^ HEAD | cleandiff
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
	grep -r $1 $2* | grep def
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

# Public: Git Push to UPstream
#         Setting a tracking branch only affects git pull.
#         This will perform a git push to wherever git pull
#         would come from, or just do "git pull" (at your command).
#
#         Most people don't encounter the problem because it'll 
#         default to pushing to a repo of the same name as your 
#         local one on origin, which is how most people's branches
#         are configured. If your local name differs from the corresponding
#         branch on origin, or you are tracking a separate repo, 
#         subtle problems can creep in if you're not paying attention.
#
#         So, always use gpup and you won't have issues.
#
# args - any arguments you pass to gpup will be passed on to git push
#
# Requirement: current_git_branch function
#         current_git_branch is expected to return the name of 
#         the current git branch.
function gpup {
	CURRENT_GIT_BRANCH=$(current_git_branch)
	REMOTE=$(git config --get "branch.$CURRENT_GIT_BRANCH.remote")
	if [ "$REMOTE" != "" ]; then
		MERGE=$(git config --get "branch.$CURRENT_GIT_BRANCH.merge" | sed -e 's/.*\///g')
		if [ "$MERGE" != "" ]; then
			if [ $# -gt 0 ]; then
				echo "running: git push $@ $REMOTE $MERGE"
				git push $@ $REMOTE $MERGE
			else
				echo "running: git push $REMOTE $MERGE"
				git push $REMOTE $MERGE
			fi
		else
			echo "Umm... you've got a remote configured but not a merge. quitting"
		fi
	else
		echo "No branch specific upstream. "
		echo "Want me to set the upstream tracking to origin/$CURRENT_GIT_BRANCH ? [enter for yes|n]"
		read SET_UPSTREAM
		if [ "$SET_UPSTREAM" != "n" ]; then
			git push --set-upstream origin $CURRENT_GIT_BRANCH
		else
			echo "Ok, you'll probably want to run something like this soon:"
			echo "    git push --set-upstream origin $CURRENT_GIT_BRANCH"
		fi
		RESPOSNE='q'
		if [ "$SET_UPSTREAM" == "" ]; then
			RESPONSE=''
		else
			echo "Continue with default? [enter for yes|q for quit]"
			read RESPONSE
		fi
		if [ "$RESPONSE" == "" ]; then 
			if [ $# -gt 0 ]; then
				echo "running: git push $@ origin $CURRENT_GIT_BRANCH"
				git push $@ $REMOTE $MERGE
			else
				echo "running: git push origin $CURRENT_GIT_BRANCH"
				git push origin $CURRENT_GIT_BRANCH
			fi
		else
			echo "quitting"
		fi
	fi
}

function rvmerize {
	echo "ruby-2.0.0-p195" > .ruby-version
	echo ${PWD##*/} > .ruby-gemset
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
if [ -f ~/.bash_work ]; then
    . ~/.bash_work
fi

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
alias berc='bundle exec rails console'
alias bers='bundle exec rails server'
alias berd='bundle exec rails server --debugger'
alias build_tags="~/brew/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude=.rsync_cache ."
alias hgrep="history | grep"

alias cleandiff="dwdiff -A best -L -s -W \" _}{\x0A%'\\\"\" -c -d \",;/:.\" --diff-input -"
alias git=hub
alias grep="grep --color=always"
alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
alias be='bundle exec'

#source ~/workspace/z/z.sh

export LANG=en_US.UTF-8

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


PATH=.:/Users/$USERNAME/bin:/Users/$USERNAME/brew/bin:/Users/$USERNAME/brew/sbin:/usr/local/rvm/bin:/usr/local/bin:$PATH:/Applications:/Users/$USERNAME/Applications:/Users/$USERNAME/Applications/bin:/Users/$USERNAME/workspace/git-status-report:/Users/$USERNAME/workspace/git_accessories:/usr/local/git/bin:/Users/$USERNAME/.gem/ruby/1.8/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
[[ -s "/usr/local/rvm" ]] && source "/usr/local/rvm" # This loads RVM into a shell session.



