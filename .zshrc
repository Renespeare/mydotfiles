HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# Benchmark purpose
zmodload zsh/zprof

# compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit

## Generate zcompdump once a day
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

function osc7 {
    setopt localoptions extendedglob
    input=( ${(s::)PWD} )
    uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
    print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}
add-zsh-hook -Uz chpwd osc7

## zinit plugins
zinit wait lucid light-mode for \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions

## zinit plugin config
zstyle ':completion:*' matcher-list 'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' menu select
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' verbose no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,bold,italic"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
export ZSH_AUTOSUGGEST_COMPLETION_IGNORE="git *"

# Default
export PATH=/usr/local/bin:/usr/bin:$HOME/.local/bin:$PATH
export LC_ALL="en_US.UTF-8"

# custom script
export PATH=$PATH:$HOME/.scripts

# Starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUSTC_WRAPPER=sccache

# Golang
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"


# SSH Agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Android SDK
export ANDROID_HOME=$HOME/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools/
export PATH=$PATH:$ANDROID_HOME/build-tools/
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# Flutter
export PATH=$PATH:$HOME/flutter/bin
export CHROME_EXECUTABLE=/usr/bin/firefox

# CMake
export CMAKE_EXPORT_COMPILE_COMMANDS=ON

# Python lib
export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/share/pkgconfig:$PKG_CONFIG_PATH

# FZF
export FZF_DEFAULT_OPTS="--ansi --height 40% --layout=reverse --border=none"
# source /usr/share/fzf/key-bindings.zsh

# Misc
export OPENCV_LOG_LEVEL=ERROR
export EDITOR=nvim

# JAVA_HOME
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
# export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
export PATH=$PATH:$JAVA_HOME/bin

alias ls="exa -lgh --icons --group-directories-first"
alias la="exa -lgha --icons --group-directories-first"

export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export DOCKER_HOST=unix:///run/docker.sock

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# rvm
# source $HOME/.rvm/scripts/rvm

# ruby
# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export GEM_HOME="$HOME/.local/share/gem/ruby/3.0.0"
export PATH="$PATH:$GEM_HOME/bin"
# export PATH="/root/.local/share/gem/ruby/3.0.0/bin:$PATH"


