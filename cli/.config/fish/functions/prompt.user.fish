function prompt.user
    if test -n "$SSH_CONNECTION" || string match -qe root "$USER"
        prompt.add $color_user $USER@$hostname
    end
end
