function rgrep
    grep --exclude-dir=.git -R $argv
end
