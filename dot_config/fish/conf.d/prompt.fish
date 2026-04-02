if status is-interactive
    set prompt_bang_symbol \u276f
    set prompt_kube_symbol \u2388
    set prompt_kube_config "$HOME/.kube/config"
    set prompt_color_reset "$(set_color normal)"

    function fish_prompt.git_trigger --on-event fish_prompt
        set -e prompt_git_status
        git rev-parse --is-inside-work-tree &>/dev/null || return

        set -g prompt_git_status "$prompt_git_symbol $prompt_git_ellipsis"
        functions --query fish_prompt.git_update && return

        fish -c "fish_prompt.git_status $prompt_git_status_file" &
        function fish_prompt.git_update --on-job-exit $last_pid
            if test -e "$prompt_git_status_file"
                read prompt_git_status <"$prompt_git_status_file"
                commandline -f repaint
                rm -f "$prompt_git_status_file"
            end
            functions -e fish_prompt.git_update
        end
    end
end

set prompt_git_ellipsis \u2026
set prompt_git_symbol \ue0a0

# [1] unstaged, [2] staged, [3] untracked, [4] conflicts
set prompt_git_markers \~ + ! \*
set prompt_git_colors yellow blue red purple

switch "$(uname)"
    case Darwin
        set prompt_git_status_file "/private/tmp/fish_git_$fish_pid"
    case \*
        set prompt_git_status_file "$XDG_RUNTIME_DIR/fish_git_$fish_pid"
end
