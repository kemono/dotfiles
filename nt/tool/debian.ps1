if (!(Test-Path ~\AppData\Local\Microsoft\WindowsApps\ubuntu1804.exe)) {

    # enable wsl
    Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -NoRestart -OutVariable results
    if ($results.RestartNeeded -eq $true) {
        Restart-Computer -Force
    }

    # make tmp directory
    Remove-Item -path C:\tmp -recurse -force
    New-Item C:\tmp -Force -ItemType Directory
    Set-Location C:\tmp

    # WSL2 install
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile C:\tmp\wsl_update_x64.msi -UseBasicParsing
    msiexec.exe /i C:\tmp\wsl_update_x64.msi /passive /norestart
    wsl --set-default-version 2

    # OS install
    Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile C:\tmp\debian.Appx -UseBasicParsing
    Add-AppxPackage C:\tmp\debian.Appx
}
