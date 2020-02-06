# make tmp directory
Remove-Item -path C:\tmp -recurse -force
New-Item C:\tmp -Force -ItemType Directory
Set-Location C:\tmp

# Yiffalicious install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("https://storage.googleapis.com/download-yiffalicious/yiffalicious_1.0_64bit.exe")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
C:\tmp\yiffalicious_1.0_64bit.exe /VERYSILENT