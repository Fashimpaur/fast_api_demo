@echo off
REM Set working directory to script's directory
cd /d %~dp0

REM Set PYTHONPATH
set PYTHONPATH=src

REM Start uvicorn in new window minimized
start "" /min uvicorn backend.controler:app --reload
