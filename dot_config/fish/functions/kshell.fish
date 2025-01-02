function kshell
    command kubectl exec -n "$1" --stdin --tty "$2" -- /bin/sh
end
