function play-movie
    # Default play speed
    if test (count $argv) -gt 1
        set play_speed $argv[2]
    else
        set play_speed 1
    end

    # Get direct video URL using yt-dlp
    set video_url (yt-dlp -g 'https://www.youtube.com/watch?v='$argv[1])

    set MPV_HOME ~/.config/mpv
    env --unset=DISPLAY \
        mpv \
        --border=no \
        --loop=yes \
        --speed=$play_speed \
        --really-quiet=yes \
        --vo=caca \
        $video_url \
        2>/dev/null

    set -e MPV_HOME
    set -e video_url
    set -e play_speed
end
