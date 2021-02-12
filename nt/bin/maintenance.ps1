C:\dotfiles\nt\bin\windows-update.ps1
C:\dotfiles\nt\bin\choco-update.ps1
C:\dotfiles\nt\bin\defender-scan.ps1
C:\dotfiles\nt\bin\repair.ps1
C:\dotfiles\nt\bin\delete-windows-log.bat

if ((Test-Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs")) {
    Remove-Item -path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -recurse -force
}
