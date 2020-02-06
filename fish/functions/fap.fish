function fap
    set gender female dickgirl
    set filetype jpg png
    set random_index (expr (expr (random) "%" 50) + 1)
    set random_gender (expr (expr (random) "%" (count $gender)) + 1)
    set random_filetype (expr (expr (random) "%" (count $filetype)) + 1)
    eval "set ids"(http -p b https://e621.net/post/index/$random_index/$gender[$random_gender]%20type:$filetype[$random_filetype]%20order:favcount | \
    xmllint --html --xpath "//span[contains(@class,'thumb')]/@id" - 2>/dev/null | sed s/id=//g | sed s/\"//g | sed s/p//g)

    set random_ids (expr (expr (random) "%" (count $ids)) + 1)
    set view_arg (http -p b https://e621.net/post/show/$ids[$random_ids] | \
    xmllint --html --xpath "string(//h4/a[1]/@href)" - 2>/dev/null | string sub -s 31)
    view-e621 $view_arg
end
