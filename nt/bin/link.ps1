# gitconfig setting
Remove-Item -path C:\Users\Gazelle\.gitconfig
cmd /c "mklink C:\Users\Gazelle\.gitconfig C:\dotfiles\.gitconfig"

# Alacritty setting
Remove-Item -Recurse -path C:\Users\Gazelle\AppData\Roaming\alacritty
cmd /c "mklink /D C:\Users\Gazelle\AppData\Roaming\alacritty C:\dotfiles\nt\etc\alacritty"
