function path-add
    if [ -e $argv[1] ]
        set -U fish_user_paths $fish_user_paths $argv[1]
    end
end
