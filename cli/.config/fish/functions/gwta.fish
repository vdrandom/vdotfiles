function gwta
    groot && cd ..
    command git worktree add $argv
    cd $argv
end
