# Created by newuser for 5.8
autoload -Uz compinit promptinit
promptinit
prompt bart

# PATH
typeset -U PATH path
path=("$HOME/.local/bin" "$HOME/.gem/ruby/3.0.0/bin" "$HOME/.cargo/bin"
    "$path[@]" "/Projects/Contrib/dmenumoji/dmenu")
export PATH

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle 'complete::complete::*' gain-privileges 1
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' ambiguous true
unsetopt listambiguous

bindkey -v


autoload -Uz add-zsh-hook

DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi
chpwd_dirstack() {
	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
}
add-zsh-hook -Uz chpwd chpwd_dirstack

DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
setopt PUSHD_MINUS

zstyle ':completion:*' rehash true

export SUDO_ASKPASS=/home/peti/.local/bin/dpass

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

alias config='git --git-dir=/home/peti/.config/dotfiles --work-tree=/home/peti'

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.config/.zsh_history

autoload -U select-word-style
select-word-style bash
export WORDCHARS='.-'
