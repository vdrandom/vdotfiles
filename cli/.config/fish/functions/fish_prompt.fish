function fish_prompt
    set -g prompt_string
    set -g prev_color
    prompt.add blue (pwd)
    prompt.git
    prompt.add normal $prompt_bang

    echo $prompt_string
    set -e prompt_string
end
