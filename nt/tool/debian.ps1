if (!(Test-Path ~\AppData\Local\Microsoft\WindowsApps\ubuntu1804.exe)) {

    # enable wsl
    Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -NoRestart -OutVariable results
    if ($results.RestartNeeded -eq $true) {
        Restart-Computer -Force
    }

    # WSL2 install
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    wsl --set-default-version 2

    # make tmp directory
    Remove-Item -path C:\tmp -recurse -force
    New-Item C:\tmp -Force -ItemType Directory
    Set-Location C:\tmp

    # OS install
    Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile C:\tmp\debian.Appx -UseBasicParsing
    Add-AppxPackage C:\tmp\debian.Appx
}
