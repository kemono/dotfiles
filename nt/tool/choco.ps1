# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
emacs git steam winrar rufus aimp ghidra `
libreoffice qbittorrent lein vivaldi `
python sysinternals vcxsrv googlechrome `
selenium-chrome-driver protonvpn vlc `
openjdk12 pwsh wireshark winpcap audacity

C:\ProgramData\chocolatey\bin\cup.exe -y all
