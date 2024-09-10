function fish_prompt.user
    if test -n "$SSH_CONNECTION" || string match -qe root "$USER"
        fish_prompt.add $USER@$hostname brblack
    end
end
