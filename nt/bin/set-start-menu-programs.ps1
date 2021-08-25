
if ((Test-Path "C:\ProgramData\Microsoft\Windows\Start Menu")) {
    Remove-Item -path "C:\ProgramData\Microsoft\Windows\Start Menu" -recurse -force
    cmd /c "mklink /D `"C:\ProgramData\Microsoft\Windows\Start Menu`" `"C:\dotfiles\nt\Start Menu`""
}

if ((Test-Path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs")) {
    Remove-Item -path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -recurse -force
}
