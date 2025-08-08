@echo off
setlocal

REM Get the script directory and project root
set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%\..
set MODULE=backend_controller

REM Call PowerShell to get config and start uvicorn
powershell -NoProfile -Command ^
  "$env:PYTHONPATH = 'src';" ^
  "$projectRoot = Resolve-Path '%PROJECT_ROOT%';" ^
  "$pidFile = Join-Path $projectRoot '%MODULE%.pid';" ^
  "$configJson = python -c \"import json; from settings import CONTROLLER_CONFIG; print(json.dumps(CONTROLLER_CONFIG['%MODULE%']))\";" ^
  "$config = $configJson | ConvertFrom-Json;" ^
  "$arguments = @('-m', 'uvicorn', \"$($config.module):app\", '--host', '0.0.0.0', '--port', \"$($config.port)\");" ^
  "$p = Start-Process -FilePath 'python' -ArgumentList $arguments -PassThru -WorkingDirectory $projectRoot -WindowStyle Hidden;" ^
  "$line = \"$($p.Id) $($config.port)\";" ^
  "Set-Content -Encoding ASCII -Path $pidFile -Value $line;" ^
  "Write-Host \"Started $($config.module) on port $($config.port) with PID $($p.Id)\""
