function view-e621
    set file_name (string split -rm1 / $argv[1])[2]
    mkdir -p ~/tmp/e621
    wget -nc https://static1.e621.net/data/$argv[1] -P ~/tmp/e621/ > /dev/null 2>&1
    view-image ~/tmp/e621/$file_name
end
