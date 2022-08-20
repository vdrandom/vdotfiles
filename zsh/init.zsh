# Source me via an absolute path
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# We rely on absolute path here, so don't do anything if it's relative
[[ $0[1] != / ]] && return

confdir=$(dirname $0)
conflist=(
    settings.zsh
    functions.zsh
)

if [[ -x $(whence powerline-go) ]]; then
    conflist+=(prompt-powerline-go.zsh)
else
    conflist+=(prompt-powerline-plain.zsh)
fi

for config in $conflist; do
    [[ -r $confdir/$config ]] && . $confdir/$config
done
