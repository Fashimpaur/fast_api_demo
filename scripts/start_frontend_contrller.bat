@echo off
setlocal

REM Define module and port
set MODULE=frontend.controller
set PORT=8080

REM Launch uvicorn in background and write the PID to frontend_controller.pid in project root
powershell -Command ^
  "$env:PYTHONPATH = 'src';" ^
  "$projectRoot = Resolve-Path '..';" ^
  "$p = Start-Process -FilePath 'python' -ArgumentList '-m', 'uvicorn', '%MODULE%:app', '--host', '0.0.0.0', '--port', '%PORT%' -PassThru -WorkingDirectory $projectRoot;" ^
  "$pidFile = Join-Path $projectRoot 'frontend_controller.pid';" ^
  "$p.Id | Out-File -Encoding ASCII $pidFile"

echo %MODULE% started on port %PORT%
