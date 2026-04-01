set prompt_bang_symbol \u276f
set prompt_kube_symbol \u2388
set prompt_kube_config "$HOME/.kube/config"
set prompt_color_reset "$(set_color normal)"

function fish_prompt
    set -g prompt_string
    set -g prev_color
    fish_prompt.add \[ brblack
    fish_prompt.user
    fish_prompt.pwd
    fish_prompt.kube
    fish_prompt.git
    fish_prompt.add \] brblack
    fish_prompt.bang

    echo "$prompt_string"
    set -e prompt_string
end

function fish_prompt.add
    set -l text $argv[1]
    if test -n $argv[2]
        set -l color "$(set_color $argv[2])"
        set value "$color$text$prompt_color_reset"
    else
        set value "$text"
    end
    if test -z "$prompt_string"
        set prompt_string "$value"
    else
        set -a prompt_string "$value"
    end
end

function fish_prompt.bang
    if ! string match -eq linux "$TERM"
        fish_prompt.add \n$prompt_bang_symbol\  brblack
    else
        fish_prompt.add \n\#\  brred
    end
end

function fish_prompt.kube
    if ! test -r "$prompt_kube_config"
        return
    end
    fish_prompt.add "$prompt_kube_symbol"
    set -l kube_context "$(awk '($1 == "current-context:") {print $2}' "$prompt_kube_config")"
    fish_prompt.add "$kube_context" green
end

function fish_prompt.pwd
    fish_prompt.add (prompt_pwd) blue
end

function fish_prompt.user
    if test -n "$SSH_CONNECTION" || string match -qe root "$USER"
        fish_prompt.add "$USER@$hostname" brblack
    end
end
