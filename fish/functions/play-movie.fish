function play-movie

    # Default play speed
    if [ (count $argv) -gt 1 ]
        set play_speed $argv[2]
    else
        set play_speed 1
    end

    youtube-dl 'https://www.youtube.com/watch?v='$argv[1] -o - |\
    mplayer \
    -cache 262144 \
    -framedrop -dr -double \
    -noar \
    -nogui \
    -nojoystick \
    -nolirc \
    -nomouseinput \
    -really-quiet \
    -speed $play_speed \
    -vo caca \
    - -loop 0
end
