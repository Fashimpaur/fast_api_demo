@echo off
if exist frontend_controller.pid (
    set /p PID=<frontend_controller.pid
    taskkill /PID %PID% /F > nul 2>&1
    del frontend_controller.pid
) else (
    echo PID file not found. Server may not be running.
)
