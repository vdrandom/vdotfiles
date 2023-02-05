function greset
    read -P "OK to reset and clean teh repo?"\n -ln1 resp
    test "$resp" != y && return 0
    command git clean -fd
    command git reset --hard
end
