set prompt_git_ellipsis \u2026
set prompt_git_symbol \ue0a0

# [1] unstaged, [2] staged, [3] untracked, [4] conflicts
set prompt_git_markers \~ + ! \*
set prompt_git_colors yellow blue red purple

switch (uname)
    case Darwin
        set prompt_git_status_file "/private/tmp/fish_git_$fish_pid"
    case \*
        set prompt_git_status_file "/var/run/$UID/fish_git_$fish_pid"
end

function fish_prompt.git
    test -n "$prompt_git_status" && fish_prompt.add "$prompt_git_status"
end

function fish_prompt.git_status
    set -l git_string $prompt_git_symbol
    set -l git_counters 0 0 0 0
    git status --porcelain -bu | while read line
        if string match -qr '^##' "$line"
            set -l git_branch "$(string match -r '[^# .]+' "$line")"
            string match -qr behind "$line" && set -a git_branch \?
            string match -qr ahead "$line" && set -a git_branch \!
            set -a git_string (string join '' $git_branch)
        else
            string match -qr "^.[MD]" "$line" && set git_counters[1] (math $git_counters[1] + 1)
            string match -qr "^[MDARC]." "$line" && set git_counters[2] (math $git_counters[2] + 1)
            string match -qr "^\?\?" "$line" && set git_counters[3] (math $git_counters[3] + 1)
            string match -qr "^[ADU]{2}" "$line" && set git_counters[4] (math $git_counters[4] + 1)
        end
    end
    for i in 1 2 3 4
        set -l color "$(set_color $prompt_git_colors[$i])"
        test $git_counters[$i] -ne 0 && set -a git_string "$color$git_counters[$i]$prompt_git_markers[$i]$prompt_color_reset"
    end
    echo "$git_string" >$argv[1]
end

function fish_prompt.git_trigger --on-event fish_prompt
    set -e prompt_git_status
    string match -qe true "$(git rev-parse --is-inside-work-tree 2>/dev/null)" || return

    set -g prompt_git_status "$prompt_git_symbol $prompt_git_ellipsis"
    functions --query fish_prompt.git_update && return

    fish -c "fish_prompt.git_status $prompt_git_status_file" &
    function fish_prompt.git_update --on-job-exit $last_pid
        if test -e "$prompt_git_status_file"
            read prompt_git_status <"$prompt_git_status_file"
            commandline -f repaint
            rm -f "$prompt_git_status_file"
        end
        functions -e fish_prompt.git_update
    end
end
