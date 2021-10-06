# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# {{{ settings
HISTSIZE=1000
HISTFILE="$HOME/.bash_history.$UID"
HISTCONTROL=ignoredups
shopt -s histappend checkwinsize autocd

export LESS='-R'
export PAGER='less'
export EDITOR='vim'
export TIME_STYLE='long-iso'
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
# }}}
# {{{ prompt
prompt_command() {
    case "$TERM" in
        (screen*) printf '\ek%s\e\\' "${HOSTNAME%%.*}";;
        (*)       printf '\e]0;%s\a' "${HOSTNAME%%.*}";;
    esac
}
((UID)) && ps_clr=4 || ps_clr=1
# just a colored version of [ $USER $HOSTNAME:$CWD ]
printf -v PS1 '\\[\\e[0m\\][ \\[\\e[3%sm\\]\\u\\[\\e[0m\\] \\h:\\[\\e[32m\\w\\[\\e[0m\\] ]\n\\$ ' $ps_clr
unset ps_clr
PROMPT_COMMAND=prompt_command
# }}}
# {{{ aliases
beep()    { printf "\007"; }
fixterm() { printf "c"; }

diff()   { command diff --color "$@"; }
less()   { command less -R "$@"; }
tailf()  { command less -R +F "$@"; }
rgrep()  { command grep --exclude-dir=\.git -R "$@"; }
whence() { command -v "$@"; }

# ls
ls() { command ls --color=auto --group-directories-first "$@"; }
ll() { command ls -lha --color=auto --group-directories-first "$@"; }

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

# vim
vi()  { command vim "$@"; }

# }}}
# {{{ plugins and traps
# bash-completion
completion_path='/usr/share/bash-completion/bash_completion'
[[ -r "$completion_path" ]] && source "$completion_path"
# grc
if [[ -x $(command -v grc) ]]; then
    cmds=(\
        cc configure cvs df diff dig gcc gmake id ip last lsof make mount \
        mtr netstat ping ping6 ps tcpdump traceroute traceroute6 \
    )
    for cmd in "${cmds[@]}"; do
        alias $cmd="command grc -es --colour=auto $cmd"
    done
    unset cmds cmd
fi
# some cool git stuff
gdiff() { /usr/bin/git diff --color "$@"; }
gdf() {
    local difftool
    if difftool=$(command -v sdiff-so-fancy); then
        gdiff "$@" | "$difftool" | less --tabs=4 -RSFX
    else
        gdiff "$@"
    fi
}
# we want to see exit code on error (it also has to be the last entry here)
trap_msg='\e[31m>>\e[0m exit \e[31m%s\e[0m\n'
trap 'printf "$trap_msg" "$?" >&2' ERR
# }}}
