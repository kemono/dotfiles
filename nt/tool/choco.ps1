# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
emacs git steam winrar rufus aimp `
libreoffice qbittorrent lein firefox `
python openssh sysinternals vim `
vcxsrv googlechrome selenium-chrome-driver `
protonvpn vlc virtualbox openjdk12

C:\ProgramData\chocolatey\bin\cup.exe -y all
