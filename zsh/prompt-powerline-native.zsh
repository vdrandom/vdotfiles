# Abandon all hope
#
# This is an implementation of powerline with git support.
# The main feature is it being asynchronous: git status is updated in parallel.
# Despite all the hours spent I have on this I am not going to use this atrocity.
# But it's sorta funny to keep this around.
#
# I see now why common powerline prompts are usually not implemented in shell.

prompt_fmtn='[ %%{\e[2;3m%%}%s%%{\e[0m%%} ] '
printf -v PROMPT2 $prompt_fmtn '%_'
printf -v PROMPT3 $prompt_fmtn '?#'
printf -v PROMPT4 $prompt_fmtn '+%N:%i'
prompt_state_file=/tmp/zsh_gitstatus_$$.tmp

precmd.home() {
    [[ $PWD =~ ^$HOME ]] && printf '~'
}

precmd.cwd() {
    typeset shifted symbol=$' \ue0b1 ' cwd=${PWD#$HOME}
    [[ -z $cwd ]] && return
    typeset -a cwd_array=(${(ps:/:)cwd})
    cwd=
    while ((${#cwd_array} > 3)); do
        shift cwd_array
        typeset shifted=1
    done
    ((shifted)) && cwd_array=(... $cwd_array)
    while ((${#cwd_array})); do
        cwd+="$cwd_array[1]$symbol"
        shift cwd_array
    done
    printf ${cwd%$symbol}
}

precmd.vars() {
    typeset user_color=blue
    ((UID)) || user_color=red

    typeset -ga prompt_strings=(
        %n::$user_color
        %m::246
        "$(precmd.home)::242"
        "$(precmd.cwd)::245"
    )
}

precmd.prompt() {
    typeset prev_color symbol=$'\ue0b0' last=$'\n\U01f525 ' fg_color=black n=1 limit=${#prompt_strings}
    typeset ps1 line val color
    ps1=
    for ((i=1; i<=limit; i++)); do
        line=$prompt_strings[$i]
        val=${line%%::*}
        color=${line##*::}
        if [[ -n $val ]]; then
            [[ -z $prev_color ]] && prev_color=$color
            ps1+="%F{$prev_color}%K{$color}$symbol%F{$fg_color} $val "
            prev_color=$color
        fi
    done
    ps1+="%F{$prev_color}%k$symbol%f$last"
    echo -n $ps1
}

precmd.is_git_repo() {
    read -r git_dir < <(git rev-parse --git-dir 2>/dev/null) || return 1
    [[ ! -e $git_dir/nozsh ]]
}

precmd.git() {
    typeset raw_status
    raw_status=$(flock -n $prompt_state_file git --no-optional-locks status --porcelain -bu 2>/dev/null) || return 0

    typeset symbol=$'\ue0a0' branch_status git_status_string IFS=
    typeset staged_count unstaged_count untracked_count unmerged_coun
    while read line; do
        if [[ $line[1,2] == '##' ]]; then
            branch_status=${line[4,-1]%%...*}
            [[ $line =~ behind    ]] && branch_status+=?
            [[ $line =~ ahead     ]] && branch_status+=!
            prompt_strings+=("$symbol $branch_status::249")
        fi
        [[ $line[1,2] == '??'     ]] && (( untracked_count++ ))
        [[ $line[1,2] =~ .[MD]    ]] && (( unstaged_count++  ))
        [[ $line[1,2] =~ [MDARC]. ]] && (( staged_count++    ))
        [[ $line[1,2] =~ [ADU]{2} ]] && (( unmerged_count++  ))
    done <<< $raw_status
    if ! ((untracked_count || unstaged_count || staged_count || unmerged_count)); then
        prompt_strings+=(ok::10)
    fi

    (( unstaged_count  )) && prompt_strings+=( "~$unstaged_count::11" )
    (( staged_count    )) && prompt_strings+=( "+$staged_count::12"   )
    (( untracked_count )) && prompt_strings+=( "-$untracked_count::9" )
    (( unmerged_count  )) && prompt_strings+=( "*$unmerged_count::14" )
}

precmd.git_update() {
    precmd.vars
    precmd.git
    precmd.prompt > $prompt_state_file
    kill -s USR1 $$
}

precmd() {
    if precmd.is_git_repo; then
        precmd.vars
        prompt_strings+=($'\ue0a0 ...'::249)
        PROMPT=$(precmd.prompt)
        precmd.git_update &!
    else
        precmd.vars
        PROMPT=$(precmd.prompt)
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
