$pidFile = "frontend_controller.pid"

if (!(Test-Path $pidFile)) {
    Write-Host "$pidFile not found. Server may not be running."
    exit 1
}

$pid_id = Get-Content $pidFile

try {
    Stop-Process -Id $pid_id -Force -ErrorAction Stop
    Remove-Item $pidFile
    Write-Host "frontend_controller stopped."
} catch {
    Write-Host "WARNING: Failed to stop frontend_controller process with PID $pid_id. PID file not deleted."
}

