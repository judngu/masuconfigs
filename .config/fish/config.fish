set -g theme_nerd_fonts yes

if test -f $HOME/.config/fish/config_work.fish
	source $HOME/.config/fish/config_work.fish
end
if test -f $HOME/.config/fish/secrets.fish
	source $HOME/.config/fish/secrets.fish
end

set -x EDITOR gvim


# Abbreviations
abbr -a gits "git status -uno"
abbr -a top "top -o cpu"
#Compensating for stupidity
abbr -a givm gvim
abbr -a gvmi gvim
abbr -a be 'bundle exec'
abbr -a ga 'git add'
abbr -a gits 'git status -uno'
abbr -a gbg 'git bisect good'
abbr -a gbb 'git bisect bad'
#End stupidity...
abbr -a epochtime "date +%s"
abbr -a epochmillis "date +%s%N | cut -b1-13"
abbr -a berc 'bundle exec rails console'
abbr -a bers 'bundle exec rails server'
abbr -a berd 'bundle exec rails server --debugger'
abbr -a build_tags "~/brew/bin/ctags -R --c++-kinds +p --fields +iaS --extra +q --exclude .rsync_cache ."
abbr -a hgrep "history | grep"

#abbr -a git hub
abbr -a ec '/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
abbr -a be 'bundle exec'
abbr -a clojure "java -cp ~/workspace/clojure-1.5.1/clojure-1.5.1.jar clojure.main"

eval (thefuck --alias | tr '\n' ';')


# PATH
set -x PATH $PATH .
set -x PATH $PATH $HOME/bin
set -x PATH $PATH $HOME/bin/git-scripts
set -x PATH $PATH /Applications
set -x PATH $PATH $HOME/.rvm/gems/ruby-2.1.2/bin
set -x PATH $PATH $HOME/.rvm/gems/ruby-2.1.2@global/bin
set -x PATH $PATH $HOME/.rvm/rubies/ruby-2.1.2/bin
set -x PATH $PATH /usr/local/opt/coreutils/libexec/gnubin
set -x PATH $PATH /usr/local/rvm/bin
set -x PATH $PATH /usr/local/bin
set -x PATH $PATH /usr/local/bin
set -x PATH $PATH /usr/bin
set -x PATH $PATH /bin
set -x PATH $PATH /usr/sbin
set -x PATH $PATH /sbin
set -x PATH $PATH /usr/local/munki
set -x PATH $PATH $HOME/Applications
set -x PATH $PATH $HOME/Applications/bin
set -x PATH $PATH $HOME/workspace/gpup
set -x PATH $PATH $HOME/workspace/git-status-report
set -x PATH $PATH $HOME/workspace/git_accessories
set -x PATH $PATH /usr/local/git/bin
set -x PATH $PATH $HOME/.gem/ruby/1.8/bin
set -x PATH $PATH $HOME/gocode/bin
set -x PATH $PATH $HOME/workspace/gocode/bin
set -x PATH $PATH $HOME/brew/bin
set -x PATH $PATH $HOME/brew/sbin
set -x PATH $PATH $HOME/workspace/useful_scripts/bin
set -x PATH $PATH /usr/local/heroku/bin

# START Bob The Fish prompt
# ~/.config/fish/functions/fish_prompt.fish
set -g theme_display_ruby no
# END Bob the Fish


rvm default
