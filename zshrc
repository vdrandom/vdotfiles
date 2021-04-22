# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# {{{ settings
# disable the bloody ^S / ^Q, I use tmux all the time anyway
stty -ixon
setopt APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS EXTENDED_GLOB AUTO_CD AUTO_PUSHD PRINT_EXIT_VALUE
unsetopt BEEP NO_MATCH NOTIFY MENU_COMPLETE AUTO_MENU

SAVEHIST=1000
HISTSIZE=1000
HISTFILE=$HOME/.histfile.$UID

export LESS='-R'
export PAGER=less
export EDITOR=vim
export TIME_STYLE=long-iso
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

autoload -Uz compinit edit-command-line
zle -N edit-command-line

# completion
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
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' rehash true
zstyle ':completion:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# }}}
# {{{ key bindings
bindkey -e
# urxvt
bindkey '^[[7~'   beginning-of-line    # home
bindkey '^[[8~'   end-of-line          # end
bindkey '^[Oc'    forward-word         # ctrl + right
bindkey '^[Od'    backward-word        # ctrl + left
bindkey '^[[3^'   delete-word          # ctrl + del
# screen
bindkey '^[[1~'   beginning-of-line    # home
bindkey '^[[4~'   end-of-line          # end
# xterm
bindkey '^[[H'    beginning-of-line    # home
bindkey '^[[F'    end-of-line          # end
# st
bindkey '^[[P'    delete-char          # del
bindkey '^[[M'    delete-word          # ctrl + del
# most of them (but not urxvt)
bindkey '^[[1;5C' forward-word         # ctrl + right
bindkey '^[[1;5D' backward-word        # ctrl + left
bindkey '^[[3;5~' delete-word          # ctrl + del
# all of them
bindkey '^[[5~'   backward-word        # page up
bindkey '^[[6~'   forward-word         # page down
bindkey '^[[3~'   delete-char          # del
bindkey '^[m'     copy-prev-shell-word # alt + m
bindkey -s '^j'   '^atime ^m'          # ctrl + j

# command line editing
bindkey '^x^e'    edit-command-line
# }}}
# {{{ prompt
prompt_fmt='%%k%%f[ %s %s:%s %s]\n> '
prompt_user='%F{%(!.red.blue)}%n%f'
prompt_host='%m'
prompt_cwd='%F{green}%d%f'
prompt_git_fmt='\ue0a0 %s %s%%f '
prompt_state_file=${RUN_DIR:-/run/user/$UID}/zsh_gitstatus_$$.tmp
PROMPT=$'%k%f[ %n %m:%d ]\n> '
PROMPT2='%k%f[ %_ ] '
PROMPT3='%k%f[ ?# ] '
PROMPT4='%k%f[ +%N:%i ] '
precmd.title() {
    case $TERM in
        (screen*) printf '\033k%s\033\\' ${HOST%%.*};;
        (*)       printf '\033]2;%s\007' ${HOST%%.*};;
    esac
}
precmd.is_git_repo() {
    typeset curr_dir=$PWD
    while [[ -n $curr_dir ]]; do
        if [[ -r $curr_dir/.git/HEAD ]]; then
            [[ -e $curr_dir/.git/nozsh ]] && return 1
            return 0
        else
            curr_dir=${curr_dir%/*}
        fi
    done
    return 1
}
precmd.git() {
    typeset raw_status
    raw_status=$(flock -w 0 $prompt_state_file git --no-optional-locks status --porcelain -bu 2>/dev/null)
    (($?)) && return 0

    typeset branch_status git_status IFS=
    typeset staged_count=0 unstaged_count=0 untracked_count=0 unmerged_count=0

    while read line; do
        if [[ $line[1,2] == '##' ]]; then
            branch_status=${line[4,-1]%%...*}
            [[ $line =~ behind    ]] && branch_status+=?
            [[ $line =~ ahead     ]] && branch_status+=!
        fi
        [[ $line[1,2] == '??'     ]] && (( untracked_count++ ))
        [[ $line[1,2] =~ .[MD]    ]] && (( unstaged_count++  ))
        [[ $line[1,2] =~ [MDARC]. ]] && (( staged_count++    ))
        [[ $line[1,2] =~ [ADU]{2} ]] && (( unmerged_count++  ))
    done <<< $raw_status

    (( unstaged_count  )) && git_status+=%F{yellow}~$unstaged_count
    (( staged_count    )) && git_status+=%F{blue}+$staged_count
    (( untracked_count )) && git_status+=%F{red}-$untracked_count
    (( unmerged_count  )) && git_status+=%F{cyan}*$unmerged_count
    [[ -z $git_status  ]] && git_status=%F{green}ok

    printf $prompt_git_fmt $branch_status $git_status > $prompt_state_file
}
precmd.prompt() {
    printf -v PROMPT $prompt_fmt $prompt_user $prompt_host $prompt_cwd $1
}
precmd.git_update() {
    precmd.git
    kill -s USR1 $$
}
precmd() {
    precmd.title
    if precmd.is_git_repo; then
        precmd.prompt $'\ue0a0 ... '
        precmd.git_update &!
    else
        precmd.prompt ''
    fi
}
TRAPUSR1() {
    precmd.prompt "$(<$prompt_state_file)"
    zle && zle reset-prompt
}
TRAPEXIT() {
    [[ -f $prompt_state_file ]] && rm $prompt_state_file
}
# }}}
# {{{ aliases
beep()    { printf $'\007' }
fixterm() { printf $'c' }

diff()  { command diff --color $@ }
tailf() { command less -R +F $@ }
rgrep() { command grep --exclude-dir=\.git -R $@ }

# ls
ls() { command ls --color=auto --group-directories-first $@ }
if [[ -x $(whence -p exa) ]]; then
    ll() { command exa -lag --group-directories-first $@ }
else
    ll() { command ls -lha --color=auto --group-directories-first $@ }
fi

# git
gci()   { command git commit $@ }
gsl()   { command git stash list $@ }
gss()   { command git status -sbu $@ }
gup()   { command git pull $@ }
groot() { cd $(command git rev-parse --show-cdup) || return 1 }
ggrep() { command git grep $@ }
gsi()   { command tig status }

# tmux
tmux()  { command tmux -2 $@ }
atmux() { tmux attach || tmux }

# sudo
sush()  { command sudo -Es }

# vim
vi()  { command vim $@ }

# package management
if [[ -x $(whence -p paru) ]]; then
    pacman() { command paru $@ }
    yay()    { pacman $@ }
fi

# because old servers don't have new termcap dbs :<
if [[ -x $(whence -p termcompat) ]]; then
   ssh() { command termcompat ssh $@ }
fi
# }}}
# {{{ plugins
# grc
if [[ -x $(whence -p grc) ]]; then
    cmds=(\
        cc configure cvs df dig gcc gmake id ip last lsof make mount \
        mtr netstat ping ping6 ps tcpdump traceroute traceroute6 \
    )
    for cmd in $cmds[@]; do
        alias $cmd="command grc -es --colour=auto $cmd"
    done
    unset cmds cmd
fi
# some cool git stuff
gdiff() { command git diff --color $@; }
if [[ -x $(whence -p diff-so-fancy) ]]; then
    gdf() { gdiff $@ | command diff-so-fancy | command less --tabs=4 -RSFX }
else
    gdf() { gdiff $@ }
fi
greset() {
    echo "OK to reset and clean teh repo?"
    read -sq _
    (( $? )) && return 1
    /usr/bin/git clean -fd
    /usr/bin/git reset --hard
}
# }}}
