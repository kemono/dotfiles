# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
  adb `
  aimp `
  androidstudio `
  audacity `
  choco-cleaner `
  crystaldiskinfo `
  dnspy `
  emacs `
  git `
  irfanview `
  lein `
  libreoffice `
  openjdk `
  openssh `
  pcsx2 `
  powershell-core `
  protonvpn `
  python `
  qbittorrent `
  rufus `
  steam `
  sysinternals `
  tor-browser `
  vcxsrv `
  visualboyadvance `
  vivaldi.install `
  vlc `
  winpcap `
  winrar `
  wireshark

C:\ProgramData\chocolatey\bin\cup.exe -y all
