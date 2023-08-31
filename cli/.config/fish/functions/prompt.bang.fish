function prompt.bang
    if ! string match -eq linux $TERM
        prompt.add \n$fishes[(random 1 3)]\ 
    else
        prompt.add \n\#\  brred
    end
end
