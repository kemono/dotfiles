# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
  adb `
  aimp `
  androidstudio `
  choco-cleaner `
  crystaldiskinfo `
  deepl `
  dnspy `
  emacs `
  git `
  irfanview `
  lein `
  libreoffice `
  openjdk `
  openssh `
  powershell-core `
  protonvpn `
  python `
  qbittorrent `
  rufus `
  steam `
  sysinternals `
  tor-browser `
  vcxsrv `
  vivaldi.install `
  vlc `
  winpcap `
  winrar `
  wireshark

C:\ProgramData\chocolatey\bin\cup.exe -y all
