# Source me via an absolute path
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# We rely on absolute path here, so don't do anything if it's relative
[[ $0[1] != / ]] && return

confdir=$(dirname $0)
conflist=(
    settings.zsh
    functions.zsh
    prompt-powerline.zsh
)

for config in $conflist; do
    [[ -r $confdir/$config ]] && . $confdir/$config
done
