reset='%%{\e[0m%%}'
prompt_fmt='[ %s@%s %s %s]\n\U1f525 '
prompt_fmtn='[ %%{\e[2;3m%%}%s%%{\e[0m%%} ] '
prompt_user='%F{%(!.9.12)}%n%f'
prompt_host='%m'
prompt_cwd='%F{10}%d%f'
prompt_git_fmt='\ue0a0 %s:%s%%f '
prompt_state_file=/tmp/zsh_gitstatus_$$.tmp

printf -v PROMPT $prompt_fmt $prompt_user $prompt_host $prompt_cwd
printf -v PROMPT2 $prompt_fmtn '%_'
printf -v PROMPT3 $prompt_fmtn '?#'
printf -v PROMPT4 $prompt_fmtn '+%N:%i'

precmd.is_git_repo() {
    read -r git_dir < <(git rev-parse --git-dir 2>/dev/null) || return 1
    [[ ! -e $git_dir/nozsh ]]
}

precmd.git() {
    typeset raw_status
    raw_status=$(flock -n $prompt_state_file git --no-optional-locks status --porcelain -bu 2>/dev/null) || return 0

    typeset branch_status git_status IFS=
    typeset staged_count unstaged_count untracked_count unmerged_coun
    while read line; do
        if [[ $line[1,2] == '##' ]]; then
            branch_status=${line[4,-1]%%...*}
            [[ $line =~ behind    ]] && branch_status+=?
            [[ $line =~ ahead     ]] && branch_status+=!
        fi
        [[ $line[1,2] == '??'     ]] && (( untracked_count++ ))
        [[ $line[1,2] =~ .[MD]    ]] && (( unstaged_count++  ))
        [[ $line[1,2] =~ [ADU]{2} ]] && (( unmerged_count++  ))
        [[ $line[1,2] =~ [MDARC]. ]] && (( staged_count++    ))
    done <<< $raw_status

    (( untracked_count )) && git_status+=\ %F{9}-$untracked_count
    (( unstaged_count  )) && git_status+=\ %F{11}~$unstaged_count
    (( unmerged_count  )) && git_status+=\ %F{14}*$unmerged_count
    (( staged_count    )) && git_status+=\ %F{12}+$staged_count
    [[ -z $git_status  ]] && git_status=\ %F{10}ok

    printf $prompt_git_fmt $branch_status $git_status > $prompt_state_file
}

precmd.prompt() {
    printf -v PROMPT $prompt_fmt $prompt_user $prompt_host $prompt_cwd $1
}

precmd.git_update() {
    precmd.git
    kill -s USR1 $$
}

precmd() {
    if precmd.is_git_repo; then
        precmd.prompt $'\ue0a0 ... '
        precmd.git_update &!
    else
        precmd.prompt
    fi
}

TRAPUSR1() {
    precmd.prompt "$(<$prompt_state_file)"
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
