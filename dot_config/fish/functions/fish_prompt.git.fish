function fish_prompt.git
    set -l is_git_tree (git rev-parse --is-inside-work-tree 2>/dev/null)
    string match -qe 'true' "$is_git_tree" || return
    git status --porcelain -bu | while read line
        if string match -qr '^##' "$line"
            set git_branch (string match -r '[^# .]+' "$line")
            string match -qr '\[behind' $line && set git_branch "$git_branch?"
            string match -qr '\[ahead'  $line && set git_branch "$git_branch!"
            fish_prompt.add "$git_symbol $git_branch"
        else
            string match -qr "^.[MD]"    "$line" && set git_count[1] (math $git_count[1] + 1)
            string match -qr "^[MDARC]." "$line" && set git_count[2] (math $git_count[2] + 1)
            string match -qr "^\?\?"     "$line" && set git_count[3] (math $git_count[3] + 1)
            string match -qr "^[ADU]{2}" "$line" && set git_count[4] (math $git_count[4] + 1)
        end
    end
    test -n "$git_count[1]" && fish_prompt.add "$git_count[1]$git_status[1]" "$color_git[1]"
    test -n "$git_count[2]" && fish_prompt.add "$git_count[2]$git_status[2]" "$color_git[2]"
    test -n "$git_count[3]" && fish_prompt.add "$git_count[3]$git_status[3]" "$color_git[3]"
    test -n "$git_count[4]" && fish_prompt.add "$git_count[4]$git_status[4]" "$color_git[4]"
end
