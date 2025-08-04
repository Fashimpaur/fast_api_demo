@echo off
setlocal
set PYTHONPATH=%~dp0src
for /f "delims=" %%i in ('python -c "from settings import CONTROLLER_CONFIG; c = CONTROLLER_CONFIG['backend_controller']; print(f'uvicorn {c['module']}:app --host 0.0.0.0 --port {c['port']}')"' ) do set CMD=%%i

start "backend_contrrller" cmd /c "%CMD%"
timeout /t 2 > nul
for /f "tokens=2" %%a in ('tasklist /fi "windowtitle eq backend_controller" /fo list ^| findstr "PID"') do echo %%a > backend_controller.pid
endlocal
