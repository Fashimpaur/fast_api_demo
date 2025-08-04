@echo off
setlocal

set MODULE=frontend.controller
set PORT=8081

powershell -Command ^
  "$env:PYTHONPATH = 'src';" ^
  "$p = Start-Process -FilePath 'python' -ArgumentList '-m', 'uvicorn', '%MODULE%:app', '--host', '0.0.0.0', '--port', '%PORT%' -PassThru;" ^
  "$p.Id | Out-File -Encoding ASCII frontend_controller.pid"

echo frontend.controller started on port %PORT%
