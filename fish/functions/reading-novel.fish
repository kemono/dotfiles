function reading-novel
    clear
    curl -s --compressed --no-keepalive $argv[1] \
    | lynx -dump -stdin -width=(expr (tput cols) / 2 + 2) -nomargins
end
