@echo off
if exist backend_controller.pid (
    set /p PID=<backend_controller.pid
    taskkill /PID %PID% /F > nul 2>&1
    del backend_controller.pid
) else (
    echo PID file not found. Server may not be running.
)
