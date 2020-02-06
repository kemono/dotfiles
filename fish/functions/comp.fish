function comp

    set file_path (string trim -r -c / $argv[1])
    set file_name (string split / $file_path)[-1]
    set zip_file_name $file_name.zip

    zip -9qr $zip_file_name $file_path
    zstd --ultra -22 $zip_file_name

    rm $zip_file_name
end
