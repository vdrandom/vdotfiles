prompt_fmtn='[ %%{\e[2;3m%%}%s%%{\e[0m%%} ] '
printf -v PROMPT2 $prompt_fmtn '%_'
printf -v PROMPT3 $prompt_fmtn '?#'
printf -v PROMPT4 $prompt_fmtn '+%N:%i'

prompt_wt="$USERNAME@$HOST"
prompt_fifo=~/.zsh_gitstatus_$$
prompt_blimit=12
typeset -A prompt_symbols=(
    sep_a         $'\ue0b0'
    sep_b         $'\ue0b1'
    ellipsis      $'\u2026'
    ro            $'\u2717'
    ssh           $'\u266a'
    git           $'\ue0a0'
    git_unstaged  '~'
    git_staged    $'\u2713'
    git_untracked '!'
    git_unmerged  '*'
    bang          $'\n\U1f525'
)

typeset -A prompt_colors=(
    fg             '#ebdbb2'
    root           '#cc241d'
    ssh            '#d65d0e'
    cwd            '#458588'
    host           '#3c3836'
    ro             '#d65d0e'
    git_branch     '#504945'
    git_unstaged   '#d65d0e'
    git_staged     '#458588'
    git_untracked  '#cc241d'
    git_unmerged   '#689d6a'
)

precmd.is_git_repo() {
    typeset prompt_git_dir
    prompt_git_dir=$(git rev-parse --git-dir 2>/dev/null) || return 1
    [[ ! -e $prompt_git_dir/nozsh ]]
}

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
    (( UID )) || precmd.prompt.add '#' $prompt_colors[root]
}

precmd.prompt.cwd() {
    precmd.prompt.add %~ $prompt_colors[cwd]
}

precmd.prompt.host() {
    [[ -n $SSH_CONNECTION ]] || return 0
    precmd.prompt.add %m $prompt_colors[host]
    precmd.prompt.add $prompt_symbols[ssh] $prompt_colors[ssh]
}

precmd.prompt.ro() {
    [[ -w . ]] || precmd.prompt.add $prompt_symbols[ro] $prompt_colors[ro]
}

precmd.prompt.pre_git() {
    precmd.prompt.add "$prompt_symbols[git] $prompt_symbols[ellipsis]" $prompt_colors[git_branch]
}

precmd.prompt.git() {
    typeset raw_status IFS=
    raw_status=$(git status --porcelain -bu 2>/dev/null) || return 0

    typeset -A count
    while read line; do
        case $line[1,2] in
            ('##')
                typeset branch_status=${line[4,-1]%%...*}
                ((${#branch_status}>prompt_blimit)) && \
                    branch_status=$branch_status[1,$prompt_blimit]$prompt_symbols[ellipsis]
                [[ $line =~ behind ]] && branch_status+=?
                [[ $line =~ ahead  ]] && branch_status+=!
                precmd.prompt.add "$prompt_symbols[git] $branch_status" $prompt_colors[git_branch]
                ;;
            (?[MD])      (( ++count[git_unstaged] ))  ;|
            ([MDARC]?)   (( ++count[git_staged] ))    ;|
            ('??')       (( ++count[git_untracked] )) ;|
            ([ADU][ADU]) (( ++count[git_unmerged] ))
        esac
    done <<< $raw_status

    for i in git_untracked git_unmerged git_unstaged git_staged; do
        (( count[$i] )) && precmd.prompt.add "$count[$i]$prompt_symbols[$i]" $prompt_colors[$i]
    done
}

precmd.prompt() {
    precmd.prompt.init
    precmd.prompt.user
    precmd.prompt.cwd
    precmd.prompt.host
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

precmd.window_title() {
    printf '\033]0;%s\007' $prompt_wt
}

precmd() {
    precmd.window_title
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
