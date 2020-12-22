# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
aimp `
audacity `
azure-cli `
bleachbit `
choco-cleaner `
crystaldiskinfo `
curl `
dnspy `
emacs `
ghidra `
git `
googlechrome `
graphviz `
ilspy `
irfanview `
jq `
kindle `
lein `
libreoffice `
nmap `
openjdk12 `
openssh `
postman `
protonvpn `
pwsh `
python `
qbittorrent `
rufus `
selenium-chrome-driver `
steam `
sysinternals `
tor-browser `
vcxsrv `
vivaldi `
vlc `
wget `
winpcap `
winrar `
wireshark

C:\ProgramData\chocolatey\bin\cup.exe -y all
