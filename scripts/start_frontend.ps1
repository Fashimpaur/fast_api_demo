# Resolve paths
$projectRoot = Resolve-Path "$PSScriptRoot\.."
$srcPath = Join-Path $projectRoot "src"

# Module and PID file
$module = "frontend_controller"
$pidFile = Join-Path $projectRoot "$module.pid"

# Load config
$configJson = python -c "import sys, json; sys.path.insert(0, r'$srcPath'); from settings import CONTROLLER_CONFIG; print(json.dumps(CONTROLLER_CONFIG['$module']))"
if (-not $configJson) {
    Write-Error "Could not load CONTROLLER_CONFIG['$module'] from settings.py"
    exit 1
}

$config = $configJson | ConvertFrom-Json

# Prepare arguments
$arguments = @('-m', 'uvicorn', "$($config.module):app", '--host', '0.0.0.0', '--port', "$($config.port)")

# Start process
$process = Start-Process -FilePath "python" -ArgumentList $arguments -WorkingDirectory $projectRoot -WindowStyle Hidden -PassThru

# Save PID and port
"$($process.Id) $($config.port)" | Out-File -FilePath $pidFile -Encoding ascii -Force
Write-Host "Started $module on port $($config.port) with PID $($process.Id)"
