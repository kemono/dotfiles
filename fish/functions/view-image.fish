function view-image
    chafa --clear \
    --color-space din99d \
    --dither none \
    --symbols quad \
    -c 256 \
    -p on \
    -w 9 \
    $argv[1]
end
