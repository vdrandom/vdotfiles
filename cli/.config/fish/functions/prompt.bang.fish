function prompt.bang
    if ! string match -eq linux $TERM
        prompt.add \n$bang_symbol\  black
    else
        prompt.add \n\#\  brred
    end
end
