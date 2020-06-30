# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Better file matching
setopt EXTENDED_GLOB

# Alt-S inserts sudo at the beginning of the line
insert_sudo () { zle beginning-of-line; zle -U "sudo "; }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Improve killall completion
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# fuzzy matching for completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Bracket matching
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git wd zsh-syntax-highlighting z)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/home/tim/bin/idp/bin:/home/tim/bin:/home/tim/scripts:/usr/bin/vendor_perl:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
export EDITOR='vim'

# We always want to use zsh ;)
export SHELL=/usr/bin/zsh

# include bash aliases
source $HOME/.bash_aliases
source /usr/bin/virtualenvwrapper.sh

# Better history search
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward
