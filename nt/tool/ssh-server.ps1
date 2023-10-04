# ssh server

# ssh config update
New-Item C:\ProgramData\ssh -Force -ItemType Directory
Invoke-WebRequest https://raw.githubusercontent.com/kemono/dotfiles/master/nt/ProgramData/ssh/sshd_config -OutFile C:\ProgramData\ssh\sshd_config
New-Item C:/Users/Gazelle/.ssh -Force -ItemType Directory
Invoke-WebRequest https://github.com/kemono.keys -OutFile C:/Users/Gazelle/.ssh/authorized_keys

# ssh install
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# default shell change
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

# service enable
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Set-Service -Name sshd -StartupType Automatic
Start-Service -Name sshd
