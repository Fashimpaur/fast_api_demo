@echo off
setlocal

set PID_FILE=frontend_controller.pid

if not exist %PID_FILE% (
  echo frontend_controller.pid not found. Server may not be running.
  exit /b
)

set /p PID=<%PID_FILE%

powershell -Command "try { Stop-Process -Id %PID% -Force -ErrorAction Stop; exit 0 } catch { Write-Host 'Failed to stop process with PID %PID%'; exit 1 }"

REM If the above command succeeded, delete the pid file
if %ERRORLEVEL%==0 (
  del %PID_FILE%
  echo frontend_controller stopped.
) else (
  echo WARNING: frontend_controller may still be running. PID %PID% was not terminated.
)
