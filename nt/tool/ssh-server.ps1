# ssh server

# ssh config update
New-Item C:\ProgramData\ssh -Force -ItemType Directory
Invoke-WebRequest https://raw.githubusercontent.com/kemono/dotfiles/master/nt/ProgramData/ssh/sshd_config -OutFile C:\ProgramData\ssh\sshd_config
New-Item C:/Users/Gazelle/.ssh -Force -ItemType Directory
Invoke-WebRequest https://keys.kemono.app -OutFile C:/Users/Gazelle/.ssh/authorized_keys

# default shell change
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

# service enable
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
