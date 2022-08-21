prompt_fmtn='[ %%{\e[2;3m%%}%s%%{\e[0m%%} ] '
printf -v PROMPT2 $prompt_fmtn '%_'
printf -v PROMPT3 $prompt_fmtn '?#'
printf -v PROMPT4 $prompt_fmtn '+%N:%i'

prompt_fifo=~/.zsh_gitstatus_$$
typeset -A prompt_symbols=(
    sep_a         $'\ue0b0'
    sep_b         $'\ue0b1'
    ellipsis      $'\u2026'
    ro            $'\u2717'
    ssh           $'\u2191'
    git           $'\ue0a0'
    git_unstaged  '±'
    git_staged    $'\u2713'
    git_untracked '!'
    git_unmerged  '*'
    bang          $'\n\U01f525'
)
typeset -A prompt_colors=(
    fg             15
    user           53
    root           52
    ssh            90
    host           237
    cwd            234
    ro             124
    git_branch     237
    git_unstaged   130
    git_staged     25
    git_untracked  88
    git_unmerged   30
)

precmd.prompt.init() {
    typeset -g prompt_string= prev_color=
}

precmd.prompt.add() {
    (( $# < 2 )) && return 1
    typeset data=$1 color=$2
    if [[ -z $prompt_string ]]; then
        prompt_string+="%K{$color}%F{$prompt_colors[fg]} $data "
    else
        prompt_string+="%F{$prev_color}%K{$color}$prompt_symbols[sep_a]%F{$prompt_colors[fg]} $data "
    fi
    prev_color=$color
}

precmd.prompt.add_same() {
    prompt_string+="$prompt_symbols[sep_b] $* "
}

precmd.prompt.bang() {
    prompt_string+="%F{$prev_color}%k$prompt_symbols[sep_a]%f$prompt_symbols[bang] "
}

precmd.prompt.apply() {
    PROMPT=$prompt_string
    unset prompt_string
}

precmd.prompt.user() {
    typeset c=user
    (( UID )) || c=root

    precmd.prompt.add %n $prompt_colors[$c]
}

precmd.prompt.ssh() {
    [[ -n $SSH_CONNECTION ]] && precmd.prompt.add $prompt_symbols[ssh] $prompt_colors[ssh]
}

precmd.prompt.host() {
    precmd.prompt.add %m $prompt_colors[host]
}

precmd.prompt.cwd() {
    precmd.prompt.add %~ $prompt_colors[cwd]
}

precmd.prompt.ro() {
    [[ -w . ]] || precmd.prompt.add $prompt_symbols[ro] $prompt_colors[ro]
}

precmd.is_git_repo() {
    typeset prompt_git_dir
    prompt_git_dir=$(git rev-parse --git-dir 2>/dev/null) || return 1
    [[ ! -e $prompt_git_dir/nozsh ]]
}

precmd.prompt.pre_git() {
    precmd.prompt.add "$prompt_symbols[git] $prompt_symbols[ellipsis]" $prompt_colors[git_branch]
}

precmd.prompt.git() {
    typeset raw_status
    raw_status=$(git status --porcelain -bu 2>/dev/null) || return 0

    typeset -A count
    typeset branch_status git_status_string IFS=
    while read line; do
        case $line[1,2] in
            ('##')
                branch_status=${line[4,-1]%%...*}
                [[ $line =~ behind ]] && branch_status+=?
                [[ $line =~ ahead  ]] && branch_status+=!
                precmd.prompt.add "$prompt_symbols[git] $branch_status" $prompt_colors[git_branch]
                ;;
            (?[MD])      (( count[git_unstaged]++ ))  ;|
            ([MDARC]?)   (( count[git_staged]++ ))    ;|
            ('??')       (( count[git_untracked]++ )) ;|
            ([ADU][ADU]) (( count[git_unmerged]++ ))
        esac
    done <<< $raw_status

    for i in git_unstaged git_staged git_untracked git_unmerged; do
        (( count[$i] )) && precmd.prompt.add "$count[$i]$prompt_symbols[$i]" $prompt_colors[$i]
    done
}

precmd.prompt() {
    precmd.prompt.init
    precmd.prompt.user
    precmd.prompt.ssh
    precmd.prompt.host
    precmd.prompt.cwd
    precmd.prompt.ro
}

precmd.git_update() {
    precmd.prompt
    precmd.prompt.git
    precmd.prompt.bang
    [[ ! -p $prompt_fifo ]] && mkfifo -m 0600 $prompt_fifo
    echo -n $prompt_string > $prompt_fifo &!
    kill -s USR1 $$
}

precmd.prompt.update() {
    typeset -g prompt_string=$(<$prompt_fifo)
    precmd.prompt.apply
    zle && zle reset-prompt
}

precmd() {
    precmd.prompt
    if precmd.is_git_repo; then
        precmd.prompt.pre_git
        precmd.git_update &!
    fi
    precmd.prompt.bang
    precmd.prompt.apply
}

TRAPUSR1() {
    precmd.prompt.update
}

TRAPEXIT() {
    [[ -p $prompt_fifo ]] && rm $prompt_fifo
}

function zle-line-init zle-keymap-select {
    local seq=$'\e[2 q'
    [[ $KEYMAP == vicmd ]] && seq=$'\e[4 q'
    printf $seq
}

zle -N zle-line-init
zle -N zle-keymap-select