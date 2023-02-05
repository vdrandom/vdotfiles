if status is-interactive
    set prompt_sep_a \ue0b0
    set prompt_bang \n\ (set_color brblue)\u266a\ 
    set git_sign \ue0a0
    set color_fg brwhite
    set color_git_branch 3c3c3c
    set color_git yellow blue red purple

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
