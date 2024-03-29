# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

C:\ProgramData\chocolatey\bin\choco.exe install -y `
  aimp `
  choco-cleaner `
  discord `
  dnspy `
  emacs `
  git `
  lein `
  libreoffice `
  openjdk `
  powershell-core `
  protonvpn `
  python `
  qbittorrent `
  steam `
  sysinternals `
  vivaldi.install `
  vlc

C:\ProgramData\chocolatey\bin\choco.exe upgrade all -y
