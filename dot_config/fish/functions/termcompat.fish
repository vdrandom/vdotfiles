function termcompat
    set -l term $TERM
    switch $term
        case 'alacritty*' 'kitty*' 'wezterm' 'xterm-*'
            set term xterm
        case 'rxvt-unicode-*'
            set term rxvt-unicode
        case 'tmux*'
            set term screen.xterm-new
    end
    begin
        set -lx TERM $term
        command $argv
    end
end
