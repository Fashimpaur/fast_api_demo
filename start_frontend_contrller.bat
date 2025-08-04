@echo off
setlocal
set PYTHONPATH=%~dp0src
for /f "delims=" %%i in ('python -c "from settings import CONTROLLER_CONFIG; c = CONTROLLER_CONFIG['frontend_controller']; print(f'uvicorn {c['module']}:app --host 0.0.0.0 --port {c['port']}')"' ) do set CMD=%%i

start "frontend_controller" cmd /c "%CMD%"
timeout /t 2 > nul
for /f "tokens=2" %%a in ('tasklist /fi "windowtitle eq frontend_controller" /fo list ^| findstr "PID"') do echo %%a > frontend_controller.pid
endlocal
