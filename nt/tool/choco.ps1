# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
aimp `
audacity `
azure-cli `
choco-cleaner `
chromedriver `
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
microsoftazurestorageexplorer `
nmap `
openjdk `
openssh `
protonvpn `
pwsh `
python `
qbittorrent `
rufus `
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

choco install -y visualstudio2019community `
--package-parameters "--allWorkloads --locale ja-JP"

C:\ProgramData\chocolatey\bin\cup.exe -y all
