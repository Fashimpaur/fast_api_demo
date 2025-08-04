@echo off
setlocal

if not exist frontend_controller.pid (
  echo frontend_controller.pid not found. Server may not be running.
  exit /b
)

set /p PID=<frontend_controller.pid

powershell -Command "Stop-Process -Id %PID% -Force"

del frontend_controller.pid
echo frontend.controller stopped.
