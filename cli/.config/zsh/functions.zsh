# Fuck default aliases
unalias -a

testbin() { whence $@ > /dev/null }

termcompat() {
    typeset term=$TERM
    case $term in
        (alacritty*) ;&
        (kitty*) ;&
        (wezterm) ;&
        (xterm-*)
            term=xterm;;
        (rxvt-unicode*)
            term=rxvt-unicode;;
        (tmux*)
            term=screen.xterm-new;;
    esac
    TERM=$term command $@
}

addpath() {
    typeset newpath=$1
    if [[ ! $PATH =~ $newpath ]]; then
        PATH+=:$newpath
        export PATH
    fi
}

fsf() {
    typeset host prompt="SSH Remote > "
    host=$(cut -d\  -f1 $HOME/.ssh/known_hosts | sort -u | fzf --prompt=$prompt) || return 1

    termcompat ssh $host $@
}

beep()    { printf $'\007' }
fixterm() { printf $'c' }

diff()    { command diff --color $@ }
tailf()   { command less +F $@ }
grep()    { command grep --color=auto $@ }
rgrep()   { grep --exclude-dir=.git -R $@ }
s()       { termcompat ssh $@ }

if testbin nvim; then
    vi()      { command nvim $@ }
    vim()     { command nvim $@ }
fi

tmux()    { command tmux -2 $@ }
atmux()   { tmux attach || tmux }

g()       { command lazygit $@ }
tig()     { termcompat tig $@ }
gsi()     { termcompat tig status }
gci()     { command git commit $@ }
gsl()     { command git stash list $@ }
gss()     { command git status -sbu $@ }
gsw()     { command git switch $@ }
gup()     { command git pull $@ }
gwta()    { command git worktree add $@ }
gwtp()    { command git worktree prune -v }
groot()   { cd $(command git rev-parse --show-toplevel) || return 0 }
gdiff()   { command git diff --color $@; }
greset()  {
    echo "OK to reset and clean teh repo?"
    read -sq _
    (( $? )) && return 1
    command git clean -fd
    command git reset --hard
}

if testbin diff-so-fancy; then
    gdf() { gdiff $@ | command diff-so-fancy | command less --tabs=4 -RSFX }
else
    gdf() { gdiff $@ }
fi

if testbin eza; then
    ls()  { command eza --icons --group-directories-first $@ }
    ll()  { ls -alg $@ }
    ld()  { ls -dlg $@ }
else
    ls()  { command ls --color=auto --group-directories-first $@ }
    ll()  { ls -alh $@ }
    ld()  { ls -dlh $@ }
fi

# grc
if testbin grc; then
    cmds=(\
        cc configure cvs df dig gcc gmake id ip last lsof make mount \
        mtr netstat ping ping6 ps tcpdump traceroute traceroute6 \
    )
    for cmd in $cmds[@]; do
        alias $cmd="command grc -es --colour=auto $cmd"
    done
    unset cmds cmd
fi
