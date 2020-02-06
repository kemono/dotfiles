
if ((Test-Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs")) {
    Remove-Item -path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -recurse -force
}

if ((Get-ItemProperty "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs").Mode.Substring(5, 1) -ne 'l') {
    Remove-Item -path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -recurse -force
    cmd /c "mklink /D `"%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs`" `"C:\dotfiles\nt\Start Menu\Programs`""
}