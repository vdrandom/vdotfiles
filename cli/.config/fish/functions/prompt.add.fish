function prompt.add
    set color $argv[1]
    set text $argv[2]
    if test -z "$prompt_string"
        set prompt_string (set_color -b $color)(set_color $color_fg) $text
    else
        set -a prompt_string (set_color -b $color)(set_color $prev_color)$prompt_sep_a(set_color $color_fg) $text
    end
    set prev_color $color
end
