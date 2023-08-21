if ! string match -eq linux $TERM
    set prompt_bang \n\u266a\ 
    set git_sign \ue0a0
else
    set prompt_bang \n\#\ 
    set git_sign g
end

# git symbols and colors
# [1] unstaged, [2] staged, [3] untracked, [4] conflicts
set symbol_git \~ + ! \*
set color_git yellow blue red purple
set color_git_branch brblack
