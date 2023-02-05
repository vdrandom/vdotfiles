if status is-interactive
    set -l grc_cmds \
        iptables ipneighbor ipaddr iproute ip nmap netstat \
        traceroute tcpdump ss ping \
        dockerversion dockersearch dockerpull dockerps dockernetwork \
        docker-machinels dockerinfo dockerimages \
        lspci lsof lsmod lsblk lsattr getfacl id whois vmstat ulimit \
        systemctl sysctl stat pv ps ping last gcc free findmnt fdisk env du \
        dig diff df blkid
    for cmd in $grc_cmds
        command -q $cmd && alias $cmd="command grc -es --colour=auto $cmd"
    end
end
