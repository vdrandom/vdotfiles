termcompat() {
    typeset term=$TERM
    case $term in
        (alacritty*) ;&
        (kitty*) ;&
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
rgrep()   { command grep --exclude-dir=\.git -R $@ }
fwcmd()   { command firewall-cmd $@ }
s()       { termcompat ssh $@ }

tmux()    { command tmux -2 $@ }
atmux()   { tmux attach || tmux }
sush()    { command sudo -Es }

tig()     { termcompat tig $@ }
gsi()     { tig status }
gci()     { command git commit $@ }
gsl()     { command git stash list $@ }
gss()     { command git status -sbu $@ }
gup()     { command git pull $@ }
groot()   { cd $(command git rev-parse --show-toplevel) || return 1 }
ggrep()   { command git grep $@ }
gdiff()   { command git diff --color $@; }
greset()  {
    echo "OK to reset and clean teh repo?"
    read -sq _
    (( $? )) && return 1
    /usr/bin/git clean -fd
    /usr/bin/git reset --hard
}

if [[ -x $(whence -p diff-so-fancy) ]]; then
    gdf() { gdiff $@ | command diff-so-fancy | command less --tabs=4 -RSFX }
else
    gdf() { gdiff $@ }
fi

if [[ -x $(whence -p exa) ]]; then
    ls()  { command exa --group-directories-first $@ }
    ll()  { ls -alg $@ }
    ld()  { ls -dlg $@ }
else
    ls()  { command ls --color=auto --group-directories-first $@ }
    ll()  { ls -alh $@ }
    ld()  { ls -dlh $@ }
fi

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
