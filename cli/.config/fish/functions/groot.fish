function groot
    set -l root (command git rev-parse --show-toplevel)
    test $status -eq 0 && cd $root
end
