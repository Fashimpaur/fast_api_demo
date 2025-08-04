@echo off
setlocal

REM Define module and port
set MODULE=backend.controller
set PORT=8080

REM Launch uvicorn in background and write the PID to controler.pid
powershell -Command ^
  "$env:PYTHONPATH = 'src';" ^
  "$p = Start-Process -FilePath 'python' -ArgumentList '-m', 'uvicorn', '%MODULE%:app', '--host', '0.0.0.0', '--port', '%PORT%' -PassThru;" ^
  "$p.Id | Out-File -Encoding ASCII backend_controller.pid"

echo backend.controller started on port %PORT%
