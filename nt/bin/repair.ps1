Dism.exe /Online /Cleanup-image /Restorehealth
Dism.exe /Online /Cleanup-Image /StartComponentCleanup
cleanmgr.exe /D C: /VERYLOWDISK /SETUP
sfc /scannow
