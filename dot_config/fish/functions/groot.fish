function groot
    set -l is_git_worktree (command git rev-parse --is-inside-work-tree)
    string match -qe 'true' "$is_git_worktree" || return
    set -l root (command git rev-parse --show-toplevel)
    test $status -eq 0 && cd $root
end
