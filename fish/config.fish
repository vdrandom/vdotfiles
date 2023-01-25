if status is-interactive
    set prompt_sep_a \ue0b0
    set prompt_bang \n\U1f41f\ 
    set color_fg brwhite
    set color_git_branch 3c3c3c
    set color_git yellow blue red purple
    function prompt.add
        set color $argv[1]
        set text $argv[2]
        if test -z "$prompt_string"
            set prompt_string (set_color -b $color)(set_color $color_fg) $text
        else
            set -a prompt_string (set_color -b $color)(set_color $prev_color)$prompt_sep_a(set_color $color_fg) $text
        end
        set prev_color $color
    end
    function prompt.git
        git rev-parse 2>/dev/null || return
        git status --porcelain -bu | while read line
            if string match -qr "^##" "$line"
                set git_branch (string match -r "\ (.+)\.\.\." "$line")[2]
                string match -qr "\[behind" $line && set git_branch "$git_branch?"
                string match -qr "\[ahead"  $line && set git_branch "$git_branch!"
                prompt.add "$color_git_branch" "$git_branch"
            else
                string match -qr "^.[MD]"    "$line" && set git_count[1] (math $git_count[1] + 1)
                string match -qr "^[MDARC]." "$line" && set git_count[2] (math $git_count[2] + 1)
                string match -qr "^\?\?"     "$line" && set git_count[3] (math $git_count[3] + 1)
                string match -qr "^[ADU]{2}" "$line" && set git_count[4] (math $git_count[4] + 1)
            end
        end
        test -n "$git_count[1]" && prompt.add "$color_git[1]" "~$git_count[1]"
        test -n "$git_count[2]" && prompt.add "$color_git[2]" "+$git_count[2]"
        test -n "$git_count[3]" && prompt.add "$color_git[3]" "!$git_count[3]"
        test -n "$git_count[4]" && prompt.add "$color_git[4]" "*$git_count[4]"
    end
    function fish_prompt
        set -g prompt_string
        set -g prev_color
        prompt.add blue (pwd)
        prompt.git
        prompt.add normal $prompt_bang

        echo $prompt_string
        set -e prompt_string
    end
    # Commands to run in interactive sessions can go here
end
