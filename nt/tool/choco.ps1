# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
aimp `
choco-cleaner `
emacs `
ghidra `
git `
irfanview `
lein `
libreoffice `
openjdk `
openssh `
protonvpn `
pwsh `
python `
qbittorrent `
rufus `
steam `
sysinternals `
vcxsrv `
virtualbox `
vivaldi `
winpcap `
winrar `
wireshark

C:\ProgramData\chocolatey\bin\cup.exe -y all
