function fish_prompt.add
    set -l text $argv[1]
    set -l color $argv[2]
    if test -n "$color"
        set value (set_color $color)$text(set_color normal)
    else
        set value $text
    end
    if test -z "$prompt_string"
        set prompt_string $value
    else
        set -a prompt_string $value
    end
end
