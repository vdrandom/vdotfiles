function powerline_precmd() {
            #-modules venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root \
    PS1=$(
        powerline-go \
            -modules user,host,ssh,cwd,perms,git \
    )
            #-newline \
            #git
    PS1=$PS1$'\n\U01f525 '
}

function install_powerline_precmd() {
  for s in $precmd_functions[@]; do
    if [[ $s = powerline_precmd ]]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [[ "$TERM" != "linux" ]] && [[ -x $(whence powerline-go) ]]; then
    install_powerline_precmd
fi

function zle-line-init zle-keymap-select {
    local seq=$'\e[2 q'
    [[ $KEYMAP == vicmd ]] && seq=$'\e[4 q'
    printf $seq
}

zle -N zle-line-init
zle -N zle-keymap-select
