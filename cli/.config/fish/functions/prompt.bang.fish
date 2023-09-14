function prompt.bang
    if ! string match -eq linux $TERM
        prompt.add \n$fishes[(random 1 (count $fishes))]\ 
    else
        prompt.add \n\#\  brred
    end
end
