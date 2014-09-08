# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export NODE_PATH=/usr/local/lib/node_modules

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="muse"
#autoload colors; colors;
autoload -U compinit
compinit -i
setopt prompt_subst

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
plugins=(ruby brew osx gem vagrant zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH="/usr/local/share/npm/bin:/Users/max/workspace/puppet/bin:/Users/max/workspace/facter/bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/python/2.7.1/bin/:$PATH:/opt/local/bin:/Users/max/bin:/usr/local/share/python"
# for when running local source copies of puppet things
export RUBYLIB="/Users/max/workspace/mcollective-test/lib:/Users/max/workspace/marionette-collective/lib:/Users/max/workspace/puppet/lib:/Users/max/workspace/facter/lib:/Users/max/workspace/puppet-cloudpack/lib:$RUBYLIB"

sleepwatcher -d -w ~/.isightcapture.wakeup

. /Users/max/z/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}

alias rake='noglob rake'
alias vagrant='nocorrect vagrant'

DISABLE_AUTO_TITLE=true

. resty
