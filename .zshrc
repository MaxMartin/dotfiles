# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export NODE_PATH=/usr/local/lib/node_modules

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="agnoster"
autoload colors; colors;
autoload -U compinit
compinit -i
setopt prompt_subst

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

# Load known hosts file for auto-completion with ssh and scp commands
if [ -f ~/.ssh/known_hosts ]; then
  zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
  zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`
fi

alias '?'='git log --oneline --graph --decorate --date-order'
alias 'clojure'='java -cp /usr/local/Cellar/clojure/1.2.0/clojure.jar'
alias 'clojure_main'='java -cp /usr/local/Cellar/clojure/1.2.0/clojure.jar clojure.main'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github ruby brew osx rvm gem vagrant zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH="/Users/max/workspace/puppet/bin:/Users/max/workspace/facter/bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/python/2.7.1/bin/:$PATH:/opt/local/bin:/Users/max/bin:/usr/local/share/npm/bin:/usr/local/share/python"
# for when running local source copies of puppet things
export RUBYLIB="/Users/max/workspace/mcollective-test/lib:/Users/max/workspace/marionette-collective/lib:/Users/max/workspace/puppet/lib:/Users/max/workspace/facter/lib:/Users/max/workspace/puppet-cloudpack/lib:$RUBYLIB"

sleepwatcher -d -w ~/.isightcapture.wakeup

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
rvm gemset use phoenix

. /Users/max/z/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}

alias rake='noglob rake'
alias vagrant='nocorrect vagrant'
