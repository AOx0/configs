function connect --argument devi sip gtw is_ipv6
    if [ $is_ipv6 = '6' ]
        sudo ip address add $sip dev $devi
    else
        sudo ip address add $sip broadcast + dev $devi
    end

    sudo ip link set $devi up
    sudo ip route add $gtw dev $devi
    sudo ip route add default via $gtw
end
