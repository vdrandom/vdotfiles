prompt_fmtn='[ %%{\e[2;3m%%}%s%%{\e[0m%%} ] '
printf -v PROMPT2 $prompt_fmtn '%_'
printf -v PROMPT3 $prompt_fmtn '?#'
printf -v PROMPT4 $prompt_fmtn '+%N:%i'

prompt_fifo=$HOME/.zsh_gitstatus_$$
prompt_blimit=50
kube_config=$HOME/.kube/config
typeset -A prompt_symbols=(
    sep_a         $'\ue0b0'
    ellipsis      $'\u2026'
    git           $'\ue0a0'
    git_unstaged  '~'
    git_staged    $'\u2713'
    git_untracked '!'
    git_unmerged  '*'
    helm          $'\u2388'
    bang          $'\u276f'
)

typeset -A prompt_colors=(
#   fg             '15'
    root           '1'
    ssh            '15'
    cwd            '4'
    git_branch     ''
    git_unstaged   '3'
    git_staged     '6'
    git_untracked  '1'
    git_unmerged   '5'
    kube_context   '2'
    brackets       '8'
    bang           '8'
)

prompt.set_bang() {
    (( $# )) || return 1
    prompt_symbols[bang]=$1
}

precmd.window_title() {
    typeset dir=$(pwd)
    printf '\033]0;%s:%s\007' ${HOST%%.*} ${dir##*/}
}

precmd.has_kube() {
    [[ -r $kube_config ]]
}

precmd.kube_context() {
    typeset kube_context=$(awk -F- '($1 == "current") {print $3}' $kube_config)
    precmd.prompt.add $prompt_symbols[helm]
    precmd.prompt.add $kube_context $prompt_colors[kube_context]
}

precmd.is_git_repo() {
    typeset prompt_git_dir
    prompt_git_dir=$(git rev-parse --git-dir 2>/dev/null) || return 1
    [[ ! -e $prompt_git_dir/nozsh ]]
}

precmd.prompt.add() {
    (( $# )) || return 1
    typeset data=$1 color=$2
    [[ -n $prompt_string ]] && prompt_string+=" "
    if [[ -n $color ]]; then
        prompt_string+="%F{$color}$data%f"
    else
        prompt_string+="$data"
    fi
}

precmd.prompt.add_pl() {
    (( $# < 2 )) && return 1
    typeset data=$1 color=$2
    if [[ -z $prompt_string ]]; then
        prompt_string+="%K{$color}%F{$prompt_colors[fg]} $data "
    else
        prompt_string+="%F{$prev_color}%K{$color}$prompt_symbols[sep_a]%F{$prompt_colors[fg]} $data "
    fi
    prev_color=$color
}

precmd.prompt.apply() {
    PROMPT=$prompt_string
    unset prompt_string
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
    typeset -g prompt_string= prev_color=

    precmd.prompt.add '[' $prompt_colors[brackets]
    (( UID )) \
        || precmd.prompt.add '#' $prompt_colors[root]
    [[ -n $SSH_CONNECTION ]]\
        && precmd.prompt.add %n@%m $prompt_colors[ssh]

    precmd.prompt.add %~ $prompt_colors[cwd]

    if precmd.has_kube; then
        precmd.kube_context
    fi

    [[ $1 == pre_git ]]\
        && precmd.prompt.pre_git
    [[ $1 == git ]]\
        && precmd.prompt.git

    precmd.prompt.add $']\n' $prompt_colors[brackets]
    prompt_string+="%F{$prompt_colors[bang]}$prompt_symbols[bang]%f "
}

precmd.git_update() {
    precmd.prompt git
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
    precmd.window_title
    if precmd.is_git_repo; then
        precmd.prompt pre_git
        precmd.git_update &!
    else
        precmd.prompt
    fi
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
