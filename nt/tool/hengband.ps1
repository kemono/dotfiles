# make tmp directory
Remove-Item -path C:\tmp -recurse -force
New-Item C:\tmp -Force -ItemType Directory
Set-Location C:\tmp

# Yiffalicious install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("https://jaist.dl.osdn.jp/hengband/60890/hengband-2.1.4-win-20140430.zip")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
Expand-Archive -Path hengband-2.1.4-win-20140430.zip
Move-Item C:\tmp\hengband-2.1.4-win-20140430\hengband-2.1.4-win C:\tools\hengband
