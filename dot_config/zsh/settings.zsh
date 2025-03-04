# disable the bloody ^S / ^Q
stty -ixon
setopt APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS EXTENDED_GLOB AUTO_CD AUTO_PUSHD PRINT_EXIT_VALUE
unsetopt BEEP NO_MATCH NOTIFY MENU_COMPLETE AUTO_MENU

SAVEHIST=10000
HISTSIZE=10000
HISTFILE=$HOME/.histfile.$UID

for editor in hx nvim vim vi; do
    testbin $editor && break
done

export EDITOR=$editor
export LESS='i M R'
export PAGER=less
export TIME_STYLE=long-iso
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

bindkey -e
bindkey $terminfo[kdch1] delete-char
bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kend]  end-of-line
bindkey '^[' vi-cmd-mode

# autocompletion
autoload -Uz compinit

compinit
zstyle ':completion:*' completer _list _complete _ignored
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

if testbin mise; then
    eval "$(mise activate zsh)"
fi
