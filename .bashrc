# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export USERNAME=`id -nu`
export ARCHFLAGS="-arch x86_64"


## throw this at the top of your .bash_profile
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo -e " \xE2\x98\xA2"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
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
then echo "\[\033[01;34m\]$(parse_git_branch)"; fi) \$ \[\033[00m\]'

#find and open
function fao {
	find . -name $1 -exec /usr/bin/env gvim '{}' \;
}

function gpo {
	git push origin $(current_git_branch)
}

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
#End stupidity...
alias epochtime="date +%s"


#source ~/workspace/z/z.sh

export LANG=en_US.UTF-8

PATH=.:$PATH:/usr/local/bin:/Applications:/Users/$USERNAME/Applications:/Users/krhodes/Applications/bin:/Users/$USERNAME/workspace/git_accessories:/usr/local/git/bin:/Users/$USERNAME/.gem/ruby/1.8/bin

#alias ct_amber="ssh amber"
#alias ct_amberqa="ssh amber-qa"
#for suff in '' 79 80 81 82 ; do
#	alias "ct_amber$suff"="ssh amber$suff"
#done
#for suff in 01 02 03 04; do
#	export "amber$suff"=adsdev$suff
#	alias "ct_amber$suff"="ssh adsdev$suff"
#done
#
#export dev=dev-portal-aps01.kendall.corp.akamai.com
#alias ct_dev="ssh masukomi@$dev"
#
#for num in 1 2 ; do 
#	export "tomapp$num"=dev-portal-tomapp$num.kendall.corp.akamai.com
#	alias "ct_tomapp$num"="ssh masukomi@dev-portal-tomapp$num.kendall.corp.akamai.com"
#done


#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
#[[ -s "/usr/local/rvm" ]] && source "/usr/local/rvm" # This loads RVM into a shell session.

