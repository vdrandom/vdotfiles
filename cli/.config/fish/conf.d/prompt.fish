if ! string match -eq linux $TERM
    set prompt_bang \n(set_color brred)\U266a\ 
    set git_sep \ue0a0
else
    set prompt_bang \n(set_color brred)\>\ 
    set git_sep \|
end

set color_sep         grey
set color_user        green
set color_git_branch  normal

# git file status: unstaged  staged  untracked  conflicts
set color_git      yellow    green   red        purple
set state_git      \~        +       !          \*
