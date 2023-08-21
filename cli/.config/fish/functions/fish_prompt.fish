function fish_prompt
    set -g prompt_string
    set -g prev_color
    prompt.add \[
    prompt.user
    prompt.add (prompt_pwd) blue
    prompt.git
    prompt.add \]
    prompt.add $prompt_bang brred

    echo $prompt_string
    set -e prompt_string
end
