# shellcheck shell=bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=1000
HISTFILE="$HOME/.bash_history.$UID"
HISTCONTROL=ignoredups
shopt -s histappend checkwinsize autocd

export LESS='i M R'
export PAGER=less
export EDITOR=vim
export TIME_STYLE=long-iso
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

PS1='\[\e[0m\][ \u@\h \[\e[34m\]\w\[\e[0m\] ]\n\$ '

unalias ls ld ll 2>/dev/null

beep()    { printf "\007"; }
fixterm() { printf "c"; }

diff()   { command diff --color "$@"; }
tailf()  { command less +F "$@"; }
rgrep()  { command grep --exclude-dir=\.git -R "$@"; }
whence() { command -v "$@"; }

# ls
ls() { command ls --color=auto "$@"; }
ll() { ls -alh "$@"; }
ld() { ls -dlh "$@"; }

# git
gci()   { command git commit "$@"; }
gsl()   { command git stash list "$@"; }
gss()   { command git status -sbu "$@"; }
gup()   { command git pull "$@"; }
groot() { cd "$(command git rev-parse --show-cdup)" || return 1; }
ggrep() { command git grep "$@"; }
gsi()   { command tig status; }

# tmux
tmux()  { command tmux -2 "$@"; }
atmux() { tmux attach; }

# sudo
sush()  { command sudo -Es; }

# bash-completion
completion_path='/usr/share/bash-completion/bash_completion'
[[ -r "$completion_path" ]] && source "$completion_path"

# we want to see exit code on error (it also has to be the last entry here)
trap_msg='\e[31m>>\e[0m exit \e[31m%s\e[0m\n'
trap 'printf "$trap_msg" "$?" >&2' ERR
