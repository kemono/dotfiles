# make tmp directory
Remove-Item -path C:\tmp -recurse -force
New-Item C:\tmp -Force -ItemType Directory
Set-Location C:\tmp

# sbcl install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("http://prdownloads.sourceforge.net/sbcl/sbcl-2.3.2-x86-64-windows-binary.msi")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
msiexec.exe /i c:\tmp\sbcl-2.3.2-x86-64-windows-binary.msi /passive /norestart

# SDL2 64bit install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("https://www.libsdl.org/release/SDL2-2.0.12-win32-x64.zip")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
Expand-Archive -Path C:\tmp\SDL2-2.0.12-win32-x64.zip -DestinationPath C:\tmp
Move-Item C:\tmp\SDL2.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0

# SDL2 image 64bit install
$cli = New-Object System.Net.WebClient
$uri = New-Object System.Uri("https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5-win32-x64.zip")
$file = Split-Path $uri.AbsolutePath -Leaf
$cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
Expand-Archive -Path C:\tmp\SDL2_image-2.0.5-win32-x64.zip -DestinationPath C:\tmp
Move-Item C:\tmp\libjpeg-9.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0
Move-Item C:\tmp\libpng16-16.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0
Move-Item C:\tmp\libtiff-5.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0
Move-Item C:\tmp\libwebp-7.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0
Move-Item C:\tmp\zlib1.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0
Move-Item C:\tmp\SDL2_image.dll C:\Program` Files\Steel` Bank` Common` Lisp\2.0.0
