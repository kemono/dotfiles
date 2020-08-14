# make tmp directory
Remove-Item -path C:\tmp -recurse -force
New-Item C:\tmp -Force -ItemType Directory
Set-Location C:\tmp

# eDEX-UI install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("https://github.com/GitSquared/edex-ui/releases/download/v2.2.2/eDEX-UI.Windows.Installer.exe")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
c:\tmp\eDEX-UI.Windows.Installer.exe