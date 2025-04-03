if status is-interactive
    if command -q grc
        set -l grc_cmds \
            iptables ipneighbor ipaddr iproute ip nmap netstat \
            traceroute tcpdump ss ping ping6 \
            dockerversion dockersearch dockerpull dockerps dockernetwork \
            docker-machinels dockerinfo dockerimages \
            lspci lsof lsmod lsblk lsattr getfacl id whois vmstat ulimit \
            systemctl sysctl stat pv ps ping last gcc free findmnt fdisk env du \
            dig diff df blkid
        for cmd in $grc_cmds
            command -q $cmd && alias $cmd="command grc -es --colour=auto $cmd"
        end
    end

    function postexec --on-event fish_postexec
        set -l ret $status
        if test $ret -ne 0
            printf '\e[31m>>\e[39m exit \e[31m%s\e[39m\n' $ret
        end
    end

    if command -q mise
        mise activate fish | source
    end
end
