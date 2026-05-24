function dentyou
    set images \
    https://65.media.tumblr.com/2d7debc2f9973659a6067c61c6d8f11c/fbe691a233a9e9fa-3f/s1280x1920/02546c161e099dd2b1e40c7d1a1010032cfc7fe3.jpg \
    https://64.media.tumblr.com/93eff0df381fa3bb7e2a19ae1a02197a/ce25f16e63aadb24-d6/s1280x1920/6cc0568af3b3268da811864e8c4f91c4cb8fb73c.jpg \
    https://64.media.tumblr.com/34aab5142a81323920dd42eb3eea6d75/69b306802fea3fd8-fa/s1280x1920/c90e1f94f0d3a95c1732750fecf43be243ec349b.png \
    https://64.media.tumblr.com/2c1cc522a6cf11a13d249bd69086c5a8/tumblr_mrelh2Ls2e1qkm02zo1_1280.pnj \
    https://64.media.tumblr.com/08c264759f370043ae6d13a3f4ece629/tumblr_mlybllDMcC1qkm02zo1_1280.pnj

    set image_url $images[(expr (expr (random) "%" 3) + 1)]
    set file_name (echo (string split -rm1 / $image_url)[2] | nkf -w --url-input)
    mkdir -p ~/tmp/dentyou
    wget -nc $image_url -P ~/tmp/dentyou/ > /dev/null 2>&1
    view-image ~/tmp/dentyou/$file_name
end
