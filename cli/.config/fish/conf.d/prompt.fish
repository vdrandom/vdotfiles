if ! string match -eq linux $TERM
    set prompt_sep \ue0b0
    set prompt_bang \n\ (set_color brred)\u266a\ 
    set git_sign \ue0a0
else
    set prompt_bang \n\ (set_color brred)\#\ 
    set git_sign g
end

set color_fg brwhite
set color_git_branch 3c3c3c
set color_git yellow blue red purple
