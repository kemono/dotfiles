function play-movie

    # Default play speed
    if [ (count $argv) -gt 1 ]
        set play_speed $argv[2]
    else
        set play_speed 1
    end

    mpv \
    --border=no \
    --loop=yes \
    --really-quiet=yes \
    --speed=$play_speed \
    --vo=caca \
    'https://www.youtube.com/watch?v='$argv[1] \
    2>/dev/null
end
