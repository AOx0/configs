function dinit
    sudo killall -9 dnsmasq

    sudo ip link set br0 down
    sudo ip link del br0

    sudo sysctl net.ipv4.ip_forward=0
    sudo sysctl net.ipv6.conf.default.forwarding=0
    sudo sysctl net.ipv6.conf.all.forwarding=0

    sudo iptables -D FORWARD -i br0 -o wlan0 -j ACCEPT
    sudo iptables -D FORWARD -i wlan0 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT

    sudo iptables -t nat -D POSTROUTING -o wlan0 -j MASQUERADE
    sudo iptables -D FORWARD -i br0 -o br0 -j ACCEPT
end
