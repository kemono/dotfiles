#Requires -RunAsAdministrator

$logs = wevtutil el
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to get event log list"
    exit 1
}

foreach ($log in $logs) {
    wevtutil cl "$log"
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to clear event log: $log"
    }
}
