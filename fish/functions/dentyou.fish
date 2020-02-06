function dentyou
    set images \
    https://d.facdn.net/art/halsioneharu/1367126741/1367126741.halsioneharu_cvf%E3%81%AE%E3%82%B3%E3%83%94%E3%83%BC.png \
    https://d.facdn.net/art/halsioneharu/1367125497/1367125497.halsioneharu_p12-p13.png \
    https://d.facdn.net/art/halsioneharu/1376335316/1376335316.halsioneharu_system-3.png

    set image_url $images[(expr (expr (random) "%" 3) + 1)]
    set file_name (echo (string split -rm1 / $image_url)[2] | nkf -w --url-input)
    mkdir -p /tmp/dentyou
    wget -nc $image_url -P /tmp/dentyou/ > /dev/null 2>&1
    view-image /tmp/dentyou/$file_name
end
