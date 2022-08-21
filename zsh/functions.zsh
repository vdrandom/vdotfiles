# some distributions love to force some aliases upon user :<
unalias ls ll ld 2>/dev/null

beep()    { printf $'\007' }
fixterm() { printf $'c' }

diff()   { command diff --color $@ }
tailf()  { command less +F $@ }
rgrep()  { command grep --exclude-dir=\.git -R $@ }
fwcmd()  { command firewall-cmd $@ }

# ls
if [[ -x $(whence -p exa) ]]; then
    ls() { command exa --group-directories-first $@ }
    ll() { ls -alg $@ }
    ld() { ls -dlg $@ }
else
    ls() { command ls --color=auto $@ }
    ll() { ls -alh $@ }
    ld() { ls -dlh $@ }
fi

# emacs
em()  { command emacsclient -a '' "$@"}
emg() { em -c "$@" }
emt() { em -t "$@" }
emd() { command emacs --daemon &>/dev/null &! }

# git
gci()    { command git commit $@ }
gsl()    { command git stash list $@ }
gss()    { command git status -sbu $@ }
gup()    { command git pull $@ }
groot()  { cd $(command git rev-parse --show-toplevel) || return 1 }
ggrep()  { command git grep $@ }
gsi()    { command tig status }
gdiff()  { command git diff --color $@; }
greset() {
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


# tmux
tmux()  { command tmux -2 $@ }
atmux() { tmux attach || tmux }

# sudo
sush()  { command sudo -Es }

# vim
vi()    { command vim $@ }

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
