function fish_prompt.add.pl
    set -l color $argv[1]
    set -l text $argv[2]
    set -l sep ''
    if test -n "$prompt_sep"
        set sep (set_color $prev_color)$prompt_sep(set_color $color_fg)
        set prev_color $color
    end
    if test -z "$prompt_string"
        set prompt_string (set_color -b $color)(set_color $color_fg) $text
    else
        set -a prompt_string (set_color -b $color)$sep $text
    end
end
