function fish_prompt.bang
    if ! string match -eq linux $TERM
        fish_prompt.add \n$bang_symbol\  brblack
    else
        fish_prompt.add \n\#\  brred
    end
end
