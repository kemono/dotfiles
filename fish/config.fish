## ------------------------------------------------------------------------
##                           Init Settings
## ------------------------------------------------------------------------

# Path to Oh My Fish install.
set -q XDG_DATA_HOME
and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Path add
if test -d $HOME/.cargo/bin
    set -x PATH  $HOME/.cargo/bin $PATH
end

# display setting
if test -d /mnt/c
    and test -z $DISPLAY
    set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}')":0"
end

## ------------------------------------------------------------------------
##                             Alias (Git)
## ------------------------------------------------------------------------

alias g 'git'

alias gs   'g status'
alias gd   'g diff'
alias gt   'g tree'
alias gf   'g fetch -p'
alias ga   'g add -A'
alias gb   'g branch'
alias gc   'g checkout'
alias gaa  'ga; g commit'
alias gddv 'gf; git diff origin/develop'
alias gdms 'gf; git diff origin/master'
alias gmdv 'gf; git merge origin/develop'
alias gmms 'gf; git merge origin/master'
alias gpdv 'g push origin develop; gf'
alias gpms 'g push origin master; gf'

## ------------------------------------------------------------------------
##                             Alias (Emacs)
## ------------------------------------------------------------------------

alias ec    'emacsclient -nw -a ""'
alias ek    'emacsclient -e "(kill-emacs)"'
alias emacs 'ec'

## ------------------------------------------------------------------------
##                             Alias (Movie)
## ------------------------------------------------------------------------

# fnaf
alias fnaf-1  'play-movie l18A5BOTlzE'
alias fnaf-2  'play-movie gk-aCL6eyGc'
alias fnaf-3  'play-movie AibtyCAhyQE'
alias fnaf-4  'play-movie YREhVveHq9k'
alias fnaf-sl 'play-movie kXMwZNRiPe0'

# music video
alias beep-beep       'play-movie wCZFISvHmyY'
alias chosen          'play-movie aJgOdZN4HcA'
alias civ4-intro      'play-movie ZRUnoGmwNCA'
alias die-young       'play-movie -PKNuZovuSw'
alias let-it-happen   'play-movie pFptt7Cargc'
alias no-mercy        'play-movie S9uTScSgzrM'
alias olympic         'play-movie bzdxwj4422Q'
alias ppap            'play-movie Ct6BUPvE2sM'
alias right-now       'play-movie 8ZSN56ghPig'
alias wdtfs           'play-movie jofNR_WkoCE'
alias winter-wrap-up  'play-movie L9BAeyZhAdE'

alias bna-op          'play-movie 3Okzra8Anr4'
alias bna-ed          'play-movie WWTFfEnMCCc'

## ------------------------------------------------------------------------
##                              Alias (Novel)
## ------------------------------------------------------------------------

alias academic        'reading-novel https://www.aozora.gr.jp/cards/000296/files/47061_29420.html'
alias bocchan         'reading-novel https://www.aozora.gr.jp/cards/000148/files/752_14964.html'
alias dogra-magra     'reading-novel https://www.aozora.gr.jp/cards/000096/files/2093_28841.html'
alias gon-fox         'reading-novel https://www.aozora.gr.jp/cards/000121/files/628_14895.html'
alias guskoved        'reading-novel https://www.aozora.gr.jp/cards/000081/files/1924_14254.html'
alias human-fail      'reading-novel https://www.aozora.gr.jp/cards/000035/files/301_14912.html'
alias i-am-cat        'reading-novel https://www.aozora.gr.jp/cards/000148/files/789_14547.html'
alias kokoro          'reading-novel https://www.aozora.gr.jp/cards/000148/files/773_14560.html'
alias kokushikan      'reading-novel https://www.aozora.gr.jp/cards/000125/files/1317_23268.html'
alias purchase-glove  'reading-novel https://www.aozora.gr.jp/cards/000121/files/637_13341.html'
alias sangetsuki      'reading-novel https://www.aozora.gr.jp/cards/000119/files/624_14544.html'

## ------------------------------------------------------------------------
##                              Alias (Othre)
## ------------------------------------------------------------------------

alias sl       'ls'
alias l        'ls -AbFhlopX --time-style="+%m/%d %H:%M" -r'

alias jnethack "~/nh/install/games/jnethack"

if test -f $HOME/.cargo/bin/bandwhich
    alias bw 'sudo $HOME/.cargo/bin/bandwhich'
end

## ------------------------------------------------------------------------
##                                   Art
## ------------------------------------------------------------------------

alias alice-hill  'view-e621 02/2c/022c0b4207177254b6c3c6754ae41d15.jpg'
alias alopex      'view-e621 cc/d2/ccd240d101fbd3f6e99762e01c196f62.png'
alias blaziken    'view-e621 bb/c9/bbc97362894236614a48f1bb07c605c1.gif'
alias fatima      'view-e621 7b/3f/7b3f758edbc4b4e6ed42012e8beb53bf.png'
alias fox         'view-e621 cf/77/cf772d3a9b9b41ea77992a5aaa5ad98c.png'
alias foxy        'view-e621 35/8a/358a98405dbdd89e1229d06f9b5f0130.jpg'
alias gardevoir   'view-e621 f9/37/f937094bac1fac5f973738c09cfeeeb4.jpg'
alias hyena       'view-e621 89/c9/89c910c749ae70de8e162195648eb277.png'
alias isabelle    'view-e621 b2/b1/b2b10c6a5f8c685f85884a75e5d807b7.gif'
alias kindred     'view-e621 40/ce/40ce16650c0e84962494a0049f6f3ade.gif'
alias kishibe     'view-e621 34/9b/349bbc2c70fb5bf3029956e4c06f40c7.jpg'
alias kobold      'view-e621 42/33/42335f8eb3d1d0d65cd34e575010e0bb.png'
alias krystal     'view-e621 34/c6/34c645e8371dd9a46be6307e65627ea3.jpg'
alias leopard     'view-e621 77/a7/77a7637d2bb25aad552897ffc777a8a4.png'
alias lopunny     'view-e621 eb/58/eb580c1131ead30b756938ba213e5dad.gif'
alias lucario     'view-e621 79/b6/79b6ec5d5b994f224dc605505c963609.png'
alias pantherine  'view-e621 9b/90/9b900ecfed47f61f618feef31f4320fe.jpg'
alias renamon     'view-e621 4f/83/4f838f319e2010539b0ba25446cfc3a2.png'
alias sierra      'view-e621 e5/40/e5400a5c4eeb6b8e11cb2b49bb8fecee.jpg'
alias tiger       'view-e621 fa/73/fa73ef397af77653307fb374d2abe97d.gif'
alias vela        'view-e621 37/2f/372fce0fb20c785613b11249f3de0942.png'
alias weavile     'view-e621 b9/5a/b95a47c8ca2ec9a8f36ca7b6c1fe4305.gif'
