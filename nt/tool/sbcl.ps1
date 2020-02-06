# make tmp directory
Remove-Item -path C:\tmp -recurse -force
New-Item C:\tmp -Force -ItemType Directory
Set-Location C:\tmp

# sbcl install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("http://prdownloads.sourceforge.net/sbcl/sbcl-2.0.0-x86-64-windows-binary.msi")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
msiexec.exe /i c:\tmp\sbcl-2.0.0-x86-64-windows-binary.msi /passive /norestart

# SDL2 64bit install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("https://www.libsdl.org/release/SDL2-2.0.9-win32-x64.zip")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
Expand-Archive -Path C:\tmp\SDL2-2.0.9-win32-x64.zip -DestinationPath C:\tmp
Move-Item C:\tmp\SDL2.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0
