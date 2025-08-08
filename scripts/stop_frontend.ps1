# Resolve the project root directory (one level up from scripts)
$projectRoot = Resolve-Path "$PSScriptRoot\.."

# Define module name and PID file
$module = "frontend_controller"
$pidFile = Join-Path $projectRoot "$module.pid"

# Stop the process if the PID file exists
if (Test-Path $pidFile) {
    $pidLine = (Get-Content $pidFile).Trim()
    $parts = $pidLine -split '\s+'

    if ($parts.Length -ge 2 -and $parts[0] -match '^\d+$' -and $parts[1] -match '^\d+$') {
        $pid_id = [int]$parts[0]
        $port = [int]$parts[1]
        try {
            Stop-Process -Id $pid_id -Force -ErrorAction Stop
            Remove-Item $pidFile -Force
            Write-Host "Stopped $module on port $port with PID $pid_id"
        } catch {
            Write-Host "Failed to stop $module with PID $pid_id on port $port. Error: $_"
        }
    } else {
        Write-Host "Invalid PID/port format in file: $pidLine"
    }
} else {
    Write-Host "PID file not found: $pidFile"
}
