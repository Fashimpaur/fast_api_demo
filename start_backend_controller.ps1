# Start FastAPI server using uvicorn as background process
$env:PYTHONPATH = "src"
Start-Process uvicorn -ArgumentList "backend.controler:app --reload" -WorkingDirectory "$PSScriptRoot" -WindowStyle Minimized
