# gitconfig setting
Remove-Item -path C:\Users\Gazelle\.gitconfig
cmd /c "mklink C:\Users\Gazelle\.gitconfig C:\dotfiles\.gitconfig"
