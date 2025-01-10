# Fuck default aliases
unalias -a

function testbin { whence $@ > /dev/null }

function termcompat {
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

function addpath {
    typeset newpath=$1
    if [[ ! $PATH =~ $newpath ]]; then
        PATH+=:$newpath
        export PATH
    fi
}

function fsf {
    typeset host prompt="SSH Remote > "
    host=$(cut -d\  -f1 $HOME/.ssh/known_hosts | sort -u | fzf --prompt=$prompt) || return 1

    termcompat ssh $host $@
}

function beep    { printf $'\007' }
function fixterm { printf $'\u001bc' }

function cm      { command chezmoi $@ }
function diff    { command diff --color $@ }
function tailf   { command less +F $@ }
function grep    { command grep --color=auto $@ }
function rgrep   { grep --exclude-dir=.git -R $@ }
function s       { termcompat ssh $@ }
function zj      { command zellij $@ }

function tmux    { command tmux -2 $@ }
function atmux   { tmux attach || tmux }

function ksw     { command kubecm switch $@ }
function k       { command kubectl $@ }
function kg      { command kubectl get $@ }
function kc      { command kubectl config $@ }
function kshell  { command kubectl exec -n $1 --stdin --tty $2 -- /bin/sh }

function g       { command lazygit $@ }
function gci     { command git commit $@ }
function gsl     { command git stash list $@ }
function gss     { command git status -sbu $@ }
function gsw     { command git switch $@ }
function gup     { command git pull $@ }
function gwta    { command git worktree add $@ }
function gwtp    { command git worktree prune -v }
function groot   { cd $(command git rev-parse --show-toplevel) || return 0 }
function gdiff   { command git diff --color $@ }
function greset  {
    echo "OK to reset and clean teh repo?"
    read -sq _
    (( $? )) && return 1
    command git clean -fd
    command git reset --hard
}

if testbin diff-so-fancy; then
    function gdf { gdiff $@ | command diff-so-fancy | command less --tabs=4 -RSFX }
else
    function gdf { gdiff $@ }
fi

if testbin eza; then
    function ls  { command eza --group-directories-first $@ }
    function ll  { ls -alg $@ }
    function ld  { ls -dlg $@ }
else
    function ls  { command ls --color=auto --group-directories-first $@ }
    function ll  { ls -alh $@ }
    function ld  { ls -dlh $@ }
fi

# grc
if testbin grc; then
    cmds=(\
        cc configure cvs df dig gcc gmake id ip last lsof make mount \
        mtr netstat ping ping6 ps tcpdump traceroute traceroute6 \
    )
    for cmd in $cmds; do
        eval "function $cmd { command grc -es --colour=auto $cmd \$@ }"
    done
    unset cmds cmd
fi
