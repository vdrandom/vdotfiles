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
