function prompt.bang
    if ! string match -eq linux $TERM
        prompt.add \n$bang_symbol\  brblack
    else
        prompt.add \n\#\  brred
    end
end
