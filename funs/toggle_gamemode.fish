function toggle_gamemode
    set HYPRGAMEMODE (hyprctl getoption animations:enabled | sed -n '1p' | awk '{print $2}')
    echo $HYPRGAMEMODE
    if [ $HYPRGAMEMODE = 1 ]
        hyprctl --batch "\
            keyword animations:enabled false;\
            keyword decoration:shadow:enabled false;\
            keyword decoration:blur:enabled false;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 0;\
            keyword decoration:rounding false;\
            keyword misc:vfr true;"
    else
        hyprctl reload
    end
end
