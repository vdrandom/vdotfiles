# Fuck default aliases
unalias -a

function addpath {
    typeset newpath=$1
    if [[ ! $PATH =~ $newpath ]]; then
        PATH+=:$newpath
        export PATH
    fi
}

function testbin { whence $@ > /dev/null }

function cm      { command chezmoi $@ }
function diff    { command diff --color $@ }
function tailf   { command less +F $@ }
function grep    { command grep --color=auto $@ }
function rgrep   { grep --exclude-dir=.git -R $@ }
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
    function ls  { command eza --icons --group-directories-first $@ }
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
        iptables ipneighbor ipaddr iproute ip nmap netstat \
        traceroute tcpdump ss ping ping6 \
        dockerversion dockersearch dockerpull dockerps dockernetwork \
        docker-machinels dockerinfo dockerimages \
        lspci lsof lsmod lsblk lsattr getfacl id whois vmstat ulimit \
        systemctl sysctl stat pv ps ping last gcc free findmnt fdisk env du \
        dig diff df blkid
    )
    for cmd in $cmds; do
        eval "function $cmd { command grc -es --colour=auto $cmd \$@ }"
    done
    unset cmds cmd
fi
