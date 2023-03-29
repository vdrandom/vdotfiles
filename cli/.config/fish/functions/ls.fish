function ls
    set -l i
    if test -n "$WEZTERM_PANE"
        set i '--icons'
    end
    command exa $i --group-directories-first $argv
end
