prompt_fmtn='[ %%{\e[2;3m%%}%s%%{\e[0m%%} ] '
printf -v PROMPT2 $prompt_fmtn '%_'
printf -v PROMPT3 $prompt_fmtn '?#'
printf -v PROMPT4 $prompt_fmtn '+%N:%i'
prompt_state_file=/tmp/zsh_gitstatus_$$.tmp

PROMPT=
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
    fg             253
    user           53
    ssh            90
    root           52
    host           240
    home           237
    /              237
    dirs           234
    ro             124
    git_branch     237
    git_unstaged   130
    git_staged     25
    git_untracked  88
    git_unmerged   30
)

precmd.prompt.clear() {
    PROMPT=
}

precmd.prompt.add() {
    typeset string
    typeset data=$1 color=$2
    if [[ $color == same ]]; then
        PROMPT+="$prompt_symbols[sep_b] $data "
    else
        if ((${#PROMPT})); then
            PROMPT+="%F{$prev_color}%K{$color}$prompt_symbols[sep_a]%F{$prompt_colors[fg]} $data "
        else
            PROMPT="%K{$color}%F{$prompt_colors[fg]} $data "
        fi
        prev_color=$color
    fi
}

precmd.prompt.bang() {
    PROMPT+="%F{$prev_color}%k$prompt_symbols[sep_a]%f$prompt_symbols[bang] "
}

precmd.prompt.user() {
    typeset user_color
    ((UID)) && user_color=$prompt_colors[user] || user_color=$prompt_colors[root]

    precmd.prompt.add %n $user_color
}

precmd.prompt.ssh() {
    [[ -n $SSH_CONNECTION ]] && precmd.prompt.add $prompt_symbols[ssh] $prompt_colors[ssh]
}

precmd.prompt.host() {
    precmd.prompt.add %m $prompt_colors[host]
}

precmd.prompt.cwd() {
    typeset cwd limit=${1:-3}
    if [[ $PWD =~ ^$HOME ]]; then
        precmd.prompt.add \~ $prompt_colors[home]
        cwd=${PWD#$HOME}
    else
        precmd.prompt.add / $prompt_colors[/]
        cwd=${PWD:1}
    fi
    [[ -z $cwd ]] && return

    typeset -a cwd_array=(${(ps:/:)cwd})
    if ((${#cwd_array} > limit)); then
        precmd.prompt.add $prompt_symbols[ellipsis] $prompt_colors[dirs]
        while ((${#cwd_array} > limit)); do
            shift cwd_array
        done
    else
        precmd.prompt.add $cwd_array[1] $prompt_colors[dirs]
        shift cwd_array
    fi
    while ((${#cwd_array})); do
        precmd.prompt.add $cwd_array[1] same
        shift cwd_array
    done
}

precmd.prompt.ro() {
    [[ -w . ]] || precmd.prompt.add $prompt_symbols[ro] $prompt_colors[ro]
}

precmd.prompt.pre_git() {
    precmd.prompt.add "$prompt_symbols[git] $prompt_symbols[ellipsis]" $prompt_colors[git_branch]
}

precmd.prompt.git() {
    typeset raw_status
    raw_status=$(flock -n $prompt_state_file git --no-optional-locks status --porcelain -bu 2>/dev/null) || return 0

    typeset -A count
    typeset branch_status git_status_string IFS=
    while read line; do
        if [[ $line[1,2] == '##' ]]; then
            branch_status=${line[4,-1]%%...*}
            [[ $line =~ behind ]] && branch_status+=?
            [[ $line =~ ahead  ]] && branch_status+=!
            precmd.prompt.add "$prompt_symbols[git] $branch_status" $prompt_colors[git_branch]
        fi
        [[ $line[1,2] == '??'     ]] && (( count[git_untracked]++ ))
        [[ $line[1,2] =~ .[MD]    ]] && (( count[git_unstaged]++  ))
        [[ $line[1,2] =~ [MDARC]. ]] && (( count[git_staged]++    ))
        [[ $line[1,2] =~ [ADU]{2} ]] && (( count[git_unmerged]++  ))
    done <<< $raw_status

    for i in git_unstaged git_staged git_untracked git_unmerged; do
        (( count[$i] )) && precmd.prompt.add "$count[$i]$prompt_symbols[$i]" $prompt_colors[$i]
    done
}

precmd.is_git_repo() {
    read -r git_dir < <(git rev-parse --git-dir 2>/dev/null) || return 1
    [[ ! -e $git_dir/nozsh ]]
}

precmd.prompt() {
    precmd.prompt.clear
    precmd.prompt.user
    precmd.prompt.ssh
    precmd.prompt.host
    precmd.prompt.cwd 2
    precmd.prompt.ro
}

precmd.git_update() {
    umask 077
    precmd.prompt
    precmd.prompt.git
    precmd.prompt.bang
    > $prompt_state_file <<< $PROMPT
    kill -s USR1 $$
}

precmd() {
    if precmd.is_git_repo; then
        precmd.prompt
        precmd.prompt.pre_git
        precmd.prompt.bang
        precmd.git_update &!
    else
        precmd.prompt
        precmd.prompt.bang
    fi
}

TRAPUSR1() {
    PROMPT=$(<$prompt_state_file)
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
