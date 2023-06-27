function fish_prompt
    set -g prompt_string
    set -g prev_color
    prompt.add "$color_sep" \[
    prompt.user
    prompt.add blue (prompt_pwd)
    prompt.git
    prompt.add "$color_sep" \]
    prompt.add normal "$prompt_bang"

    echo "$prompt_string"
    set -e prompt_string
end
