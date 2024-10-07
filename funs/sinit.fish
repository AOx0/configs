function sinit
    set br0_exists (ip a | grep br0 -c)

    sudo sysctl net.ipv4.ip_forward=1
    sudo sysctl net.ipv6.conf.default.forwarding=1
    sudo sysctl net.ipv6.conf.all.forwarding=1

    
    if test "$br0_exists" = 0
        echo "Starting br0"
        sudo ip link add name br0 type bridge
        sudo ip addr add 192.168.26.1/24 dev br0
        sudo ip link set br0 up
        sudo dnsmasq --interface=br0 --bind-interfaces --listen-address=192.168.26.1 --dhcp-range=192.168.26.20,192.168.26.50,255.255.255.0,12h --except-interface=lo
    end

    sudo iptables -A FORWARD -i br0 -o wlan0 -j ACCEPT
    sudo iptables -A FORWARD -i wlan0 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT

    sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
    sudo iptables -A FORWARD -i br0 -o br0 -j ACCEPT
end
