if (Test-Path "backend_controller.pid") {
    $process_pid = Get-Content "backend_controller.pid"
    Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue
    Remove-Item "backend_controller.pid"
} else {
    Write-Host "PID file not found. Server may not be running."
}
