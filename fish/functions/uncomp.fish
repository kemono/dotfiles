function uncomp
    set zip_file_name (string replace ".zst" "" $argv[1])

    unzstd $argv[1]
    unzip -qd ./ $zip_file_name

    rm $zip_file_name
end
