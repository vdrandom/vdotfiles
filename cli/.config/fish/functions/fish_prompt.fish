function fish_prompt
    set -g prompt_string
    set -g prev_color
    prompt.add \[ brblack
    prompt.user
    prompt.add (prompt_pwd) blue
    prompt.git
    prompt.add \] brblack
    prompt.bang

    echo $prompt_string
    set -e prompt_string
end
