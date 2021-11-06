# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
  aimp `
  alacritty `
  choco-cleaner `
  crystaldiskinfo `
  dnspy `
  emacs `
  git `
  irfanview `
  kindle `
  lein `
  libreoffice `
  openjdk `
  openssh `
  powershell-core `
  protonvpn `
  python `
  qbittorrent `
  steam `
  sysinternals `
  vcxsrv `
  vivaldi.install `
  vlc `
  winrar

C:\ProgramData\chocolatey\bin\cup.exe -y all
