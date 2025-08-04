# Stop all uvicorn processes (forcefully)
Get-Process uvicorn -ErrorAction SilentlyContinue | Stop-Process -Force
