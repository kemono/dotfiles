Remove-Item -path C:\Windows\System32\drivers\etc\hosts
cmd /c "mklink C:\Windows\System32\drivers\etc\hosts C:\dotfiles\nt\Windows\System32\drivers\etc\hosts"
