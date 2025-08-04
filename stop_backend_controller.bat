@echo off
setlocal

if not exist backend_controller.pid (
  echo backend_controller.pid not found. Server may not be running.
  exit /b
)

set /p PID=<backend_controller.pid

REM Kill the process
powershell -Command "Stop-Process -Id %PID% -Force"

del backend_controller.pid
echo backend.controller stopped.
