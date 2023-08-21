function prompt.git
    set -l is_git_tree (git rev-parse --is-inside-work-tree 2>/dev/null)
    string match -qe 'true' "$is_git_tree" || return
    git status --porcelain -bu | while read line
        if string match -qr '^##' "$line"
            set git_branch (string match -r '[^# .]+' "$line")
            string match -qr '\[behind' $line && set git_branch "$git_branch?"
            string match -qr '\[ahead'  $line && set git_branch "$git_branch!"
            prompt.add "$git_sign $git_branch" "$color_git_branch"
        else
            string match -qr "^.[MD]"    "$line" && set git_count[1] (math $git_count[1] + 1)
            string match -qr "^[MDARC]." "$line" && set git_count[2] (math $git_count[2] + 1)
            string match -qr "^\?\?"     "$line" && set git_count[3] (math $git_count[3] + 1)
            string match -qr "^[ADU]{2}" "$line" && set git_count[4] (math $git_count[4] + 1)
        end
    end
    test -n "$git_count[1]" && prompt.add "$git_count[1]$symbol_git[1]" "$color_git[1]"
    test -n "$git_count[2]" && prompt.add "$git_count[2]$symbol_git[2]" "$color_git[2]"
    test -n "$git_count[3]" && prompt.add "$git_count[3]$symbol_git[3]" "$color_git[3]"
    test -n "$git_count[4]" && prompt.add "$git_count[4]$symbol_git[4]" "$color_git[4]"
end
