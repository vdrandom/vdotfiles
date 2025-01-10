function fish_prompt.kube
    if ! test -r "$kube_config"
        return
    end
    fish_prompt.add "$kube_symbol"
    set -l kube_context (awk -F- '($1 == "current") {print $3}' "$kube_config")
    fish_prompt.add "$kube_context" green
end
