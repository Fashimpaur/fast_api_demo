@echo off
setlocal

REM Get the directory where this batch file lives
set SCRIPT_DIR=%~dp0

REM Remove trailing backslash
if "%SCRIPT_DIR:~-1%"=="\" set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%

REM PID file is in the parent of the script directory (i.e. project root)
set PID_FILE=%SCRIPT_DIR%\..\frontend_controller.pid

REM Normalize the path (optional but recommended)
for %%I in ("%PID_FILE%") do set PID_FILE=%%~fI

if not exist "%PID_FILE%" (
  echo frontend_controller.pid not found. Server may not be running.
  exit /b 1
)

REM Read PID from file
for /f %%P in (%PID_FILE%) do set PID=%%P

REM Debug: show raw PID
echo Read PID: [%PID%]

REM Let PowerShell do the numeric check and stop
powershell -NoProfile -Command ^
    "if ([int]::TryParse('%PID%', [ref]0)) { try { Stop-Process -Id %PID% -Force -ErrorAction Stop; exit 0 } catch { Write-Host 'Failed to stop frontend_controller process with PID %PID%'; exit 1 } } else { Write-Host 'Invalid PID format: %PID%'; exit 1 }"

REM If the above command succeeded, delete the pid file
if %ERRORLEVEL%==0 (
  del "%PID_FILE%"
  echo frontend_controller stopped.
) else (
  echo WARNING: frontend_controller may still be running. PID %PID% was not terminated.
)
