# ssh server

# ssh config update
Invoke-WebRequest https://raw.githubusercontent.com/kemono/dotfiles/master/nt/ProgramData/ssh/sshd_config -OutFile C:\ProgramData\ssh\sshd_config
Invoke-WebRequest https://keys.kemono.app -OutFile ~/.ssh/authorized_keys

# default shell change
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# service enable
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
