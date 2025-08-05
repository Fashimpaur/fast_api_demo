$env:PYTHONPATH = "$PSScriptRoot\src"
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition
$pidFile = Join-Path $scriptDirectory "backend_controller.pid"

$config = python -c "from settings import CONTROLLER_CONFIG; c = CONTROLLER_CONFIG['backend_controller']; print(f'uvicorn {c['module']}:app --host 0.0.0.0 --port {c['port']}')"
$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c $config" -WindowStyle Hidden -PassThru
$process.Id | Out-File -FilePath "$pidFile" -Encoding ascii -Force
