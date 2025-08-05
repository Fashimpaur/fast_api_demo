# Set PYTHONPATH relative to the project root
$projectRoot = Resolve-Path "$PSScriptRoot\.."
$env:PYTHONPATH = Join-Path $projectRoot "src"

# Output PID file in project root
$pidFile = Join-Path $projectRoot "backend_controller.pid"

# Load configuration via Python (relies on PYTHONPATH above)
$config = python -c "from settings import CONTROLLER_CONFIG; c = CONTROLLER_CONFIG['backend_controller']; print(f'uvicorn {c['module']}:app --host 0.0.0.0 --port {c['port']}')"

# Start uvicorn and write PID
$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c $config" -WindowStyle Hidden -PassThru
$process.Id | Out-File -FilePath "$pidFile" -Encoding ascii -Force
