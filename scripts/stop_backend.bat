@echo off
setlocal

REM Get the directory where this batch file lives
set SCRIPT_DIR=%~dp0
set MODULE=backend_controller

REM Remove trailing backslash
if "%SCRIPT_DIR:~-1%"=="\" set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%

REM PID file is in the parent of the script directory (i.e. project root)
set PID_FILE=%SCRIPT_DIR%\..\%MODULE%.pid

REM Normalize the path
for %%I in ("%PID_FILE%") do set PID_FILE=%%~fI

if not exist "%PID_FILE%" (
  echo %MODULE%.pid not found. Server may not be running.
  exit /b 1
)

REM Read port and PID from file
for /f "tokens=1,2" %%A in (%PID_FILE%) do (
  set PID_ID=%%A
  set PORT=%%B
)

REM Debug: show values
REM echo Read PID: [%PID_ID%] on port [%PORT%]

REM Check if process exists (suppressing output)
tasklist /FI "PID eq %PID_ID%" >nul 2>&1

powershell -NoProfile -Command ^
    "if ([int]::TryParse('%PID_ID%', [ref]0)) { try { Stop-Process -Id %PID_ID% -Force -ErrorAction Stop; exit 0 } catch { Write-Host 'Failed to stop %MODULE% process with PID %PID_ID%'; exit 1 } } else { Write-Host 'Invalid PID format: %PID_ID%'; exit 1 }"

REM If the above command succeeded, delete the pid file
if %ERRORLEVEL%==0 (
  del "%PID_FILE%"
  echo Stopped %MODULE% on port %PORT% with PID %PID_ID%
) else (
  echo WARNING: %MODULE% may still be running. PID %PID_ID% was not terminated.
)
