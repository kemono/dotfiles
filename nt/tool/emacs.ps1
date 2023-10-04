# make tmp directory
Remove-Item -path C:\tmp -recurse -force
New-Item C:\tmp -Force -ItemType Directory
Set-Location C:\tmp

# emacs and sbcl settings
C:\ProgramData\chocolatey\bin\choco.exe install -y emacs

if (!(Test-Path "~/quicklisp")) {
    $cli = New-Object System.Net.WebClient
    $uri = New-Object System.Uri("https://beta.quicklisp.org/quicklisp.lisp")
    $file = Split-Path $uri.AbsolutePath -Leaf
    $cli.DownloadFile($uri, (Join-Path "C:\tmp\" $file))
    C:\Program` Files\Steel` Bank` Common` Lisp\sbcl.exe --load quicklisp.lisp --eval "(progn (quicklisp-quickstart:install) (exit))"
}

cmd /c "mklink %userprofile%\.sbclrc C:\dotfiles\.sbclrc"
cmd /c "mklink /D %userprofile%\AppData\Roaming\.emacs.d C:\dotfiles\.emacs.d"


if (!(Test-Path "C:\projects")) {
    New-Item C:\projects -Force -ItemType Directory
}
Remove-Item -path ~\quicklisp\local-projects -recurse -force
cmd /c "mklink /D %userprofile%\quicklisp\local-projects C:\projects"
