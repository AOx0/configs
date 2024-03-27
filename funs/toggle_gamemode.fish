function toggle_gamemode
    set HYPRGAMEMODE (hyprctl getoption animations:enabled | sed -n '2p' | awk '{print $2}')
    if [ $HYPRGAMEMODE = true ]
        hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword decoration:drop_shadow 0;\
            keyword decoration:blur:enabled 0;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 0;\
            keyword decoration:rounding 0;\
            keyword misc:no_direct_scanout 0;"\ 
        exit
    end
    hyprctl reload
end
