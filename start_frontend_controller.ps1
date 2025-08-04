$env:PYTHONPATH = "$PSScriptRoot\src"
$config = python -c "from settings import CONTROLLER_CONFIG; c = CONTROLLER_CONFIG['frontend_controller']; print(f'uvicorn {c['module']}:app --host 0.0.0.0 --port {c['port']}')"
Start-Process -FilePath "cmd.exe" -ArgumentList "/c $config" -WindowStyle Hidden -PassThru | ForEach-Object { $_.Id } > frontend_controller.pid
