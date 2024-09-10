function fish_prompt
    set -g prompt_string
    set -g prev_color
    fish_prompt.add \[ brblack
    fish_prompt.user
    fish_prompt.add (prompt_pwd) blue
    fish_prompt.git
    fish_prompt.add \] brblack
    fish_prompt.bang

    echo $prompt_string
    set -e prompt_string
end
