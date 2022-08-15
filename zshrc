# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# {{{ settings
# disable the bloody ^S / ^Q, I use tmux all the time anyway
stty -ixon
setopt APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS EXTENDED_GLOB AUTO_CD AUTO_PUSHD PRINT_EXIT_VALUE
unsetopt BEEP NO_MATCH NOTIFY MENU_COMPLETE AUTO_MENU

bindkey -e
bindkey $terminfo[kdch1] delete-char
bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kend]  end-of-line
bindkey '^[' vi-cmd-mode

SAVEHIST=1000
HISTSIZE=1000
HISTFILE=$HOME/.histfile.$UID

export LESS='i M R'
export PAGER=less
export EDITOR=vim
export TIME_STYLE=long-iso
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

autoload -Uz compinit

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
# {{{ prompt
reset='%%{\e[0m%%}'
prompt_fmt='[ %s@%s:%s %s]\n\U01f4a2 '
prompt_fmtn='[ %%{\e[2;3m%%}%s%%{\e[0m%%} ] '
prompt_user='%F{%(!.red.blue)}%n%f'
prompt_host='%m'
prompt_cwd='%F{green}%d%f'
prompt_git_fmt='\ue0a0 %s %s%%f '
prompt_state_file=/tmp/zsh_gitstatus_$$.tmp

printf -v PROMPT $prompt_fmt $prompt_user $prompt_host $prompt_cwd
printf -v PROMPT2 $prompt_fmtn '%_'
printf -v PROMPT3 $prompt_fmtn '?#'
printf -v PROMPT4 $prompt_fmtn '+%N:%i'

precmd.is_git_repo() {
    read -r git_dir < <(git rev-parse --git-dir 2>/dev/null) || return 1
    [[ ! -e $git_dir/nozsh ]]
}

precmd.git() {
    typeset raw_status
    raw_status=$(flock -n $prompt_state_file git --no-optional-locks status --porcelain -bu 2>/dev/null) || return 0

    typeset branch_status git_status IFS=
    typeset staged_count unstaged_count untracked_count unmerged_coun
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
    if precmd.is_git_repo; then
        precmd.prompt $'\ue0a0 ... '
        precmd.git_update &!
    else
        precmd.prompt
    fi
}

TRAPUSR1() {
    precmd.prompt "$(<$prompt_state_file)"
    zle && zle reset-prompt
}

TRAPEXIT() {
    [[ -f $prompt_state_file ]] && rm $prompt_state_file
}

function zle-line-init zle-keymap-select {
    local seq=$'\e[2 q'
    [[ $KEYMAP == vicmd ]] && seq=$'\e[4 q'
    printf $seq
}

zle -N zle-line-init
zle -N zle-keymap-select
# }}}
# {{{ aliases
beep()    { printf $'\007' }
fixterm() { printf $'c' }

diff()  { command diff --color $@ }
tailf() { command less +F $@ }
rgrep() { command grep --exclude-dir=\.git -R $@ }
fwcmd() { command firewall-cmd $@ }

# ls
if [[ -x $(whence -p exa) ]]; then
    ls() { command exa --group-directories-first $@ }
    ll() { ls -lag $@ }
else
    ls() { command ls --color=auto $@ }
    ll() { ls -lha $@ }
fi

# git
gci()   { command git commit $@ }
gsl()   { command git stash list $@ }
gss()   { command git status -sbu $@ }
gup()   { command git pull $@ }
groot() { cd $(command git rev-parse --show-toplevel) || return 1 }
ggrep() { command git grep $@ }
gsi()   { command tig status }

# tmux
tmux()  { command tmux -2 $@ }
atmux() { tmux attach || tmux }

# sudo
sush()  { command sudo -Es }

# vim
vi()  { command vim $@ }
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
