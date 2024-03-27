function sinit_br
    sudo ip link add name br0 type bridge
    sudo ip addr add 10.0.2.1/16 dev br0
    sudo ip link set br0 up
    sudo dnsmasq --interface=br0 --bind-interfaces --dhcp-range=10.0.2.2,10.0.2.254

    sudo modprobe tun

    sudo sysctl net.ipv4.ip_forward=1
    sudo sysctl net.ipv6.conf.default.forwarding=1
    sudo sysctl net.ipv6.conf.all.forwarding=1

    sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
    sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A FORWARD -i tap0 -o wlan0 -j ACCEPT
end
