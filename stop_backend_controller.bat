@echo off
REM Stop all uvicorn processes (forcefully)
taskkill /F /IM uvicorn.exe >nul 2>&1
taskkill /F /IM python.exe >nul 2>&1
