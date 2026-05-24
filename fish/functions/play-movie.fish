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

    # Use '-u DISPLAY' for cross-platform compatibility.
    # Embed OS detection directly inside the --vo argument.
    env -u DISPLAY \
        mpv \
        --border=no \
        --loop=yes \
        --speed=$play_speed \
        --really-quiet=yes \
        --vo=(if test (uname) = "Darwin"; echo tct; else; echo caca; end) \
        $video_url \
        2>/dev/null

    # Clean up variables
    set -e MPV_HOME
    set -e video_url
    set -e play_speed
end
