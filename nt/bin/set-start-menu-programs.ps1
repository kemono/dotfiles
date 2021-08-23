
if ((Test-Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs")) {
    Remove-Item -path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -recurse -force
    cmd /c "mklink /D `"C:\ProgramData\Microsoft\Windows\Start Menu\Programs`" `"C:\dotfiles\nt\Start Menu\Programs`""
}

if ((Test-Path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs")) {
    Remove-Item -path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -recurse -force
}
