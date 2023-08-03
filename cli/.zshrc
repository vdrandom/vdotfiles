# If not running interactively, don't do anything
[[ $- != *i* ]] && return

confdir=$HOME/.config/zsh
conflist=(
    env.zsh
    settings.zsh
    prompt.zsh
    functions.zsh
    local.zsh
)

for conf in $conflist; do
    [[ -f $confdir/$conf ]] && . $confdir/$conf
done

unset conf confdir conflist
