# Resolve the project root directory (one level up from scripts)
$projectRoot = Resolve-Path "$PSScriptRoot\.."

# Point to the PID file in the project root
$pidFile = Join-Path $projectRoot "backend_controller.pid"

# Stop the process if the PID file exists
if (Test-Path $pidFile) {
    $pid = Get-Content $pidFile
    Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue
    Remove-Item $pidFile -Force
    Write-Host "Stopped backend_controller process with PID $pid."
} else {
    Write-Host "PID file not found: $pidFile"
}
