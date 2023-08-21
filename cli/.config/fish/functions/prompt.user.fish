function prompt.user
    if test -n "$SSH_CONNECTION" || string match -qe root "$USER"
        prompt.add $USER@$hostname
    end
end
